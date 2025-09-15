import json
import os
import sys
from enum import Enum
from pathlib import Path

import prompty
import prompty.azure
from azure.ai.inference.prompts import PromptTemplate
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import ConnectionType
from azure.identity import DefaultAzureCredential
from dotenv import load_dotenv
from prompty.azure.processor import ToolCall
from prompty.tracer import trace
from pydantic import BaseModel, TypeAdapter

load_dotenv()

# Create an Azure AI Client from a connection string, copied from your Azure AI Foundry project.
# At the moment, it should be in the format "<HostName>;<AzureSubscriptionId>;<ResourceGroup>;<HubName>"
# Customer needs to login to Azure subscription via Azure CLI and set the environment variables


@trace
def execute_dbresearch(question: str, feedback: str = "No feedback"):

    ai_project_conn_str = os.getenv("INPUT_AZURE_AI_PROJECT_ENDPOINT")

    project_client = AIProjectClient(
        credential=DefaultAzureCredential(),
        endpoint=ai_project_conn_str,
    )

    prompt_template = PromptTemplate.from_prompty(
        file_path="code-researcher.prompty")
    messages = prompt_template.create_messages(
        question=question, feedback=feedback)

    # conn_list = project_client.connections.list()
    # conn_id = ""
    # for conn in conn_list:
    #     if conn.connection_type == ConnectionType.AZURE_AI_SEARCH:
    #         conn_id = conn.id
    #         break

    # print(conn_id)

    # Create agent with the search tool and process assistant run
    with project_client:
        agent = project_client.agents.create_agent(
            model="gpt-4",
            name="code-researcher",
            instructions=messages[0]['content'],
            # tools=search_tool.definitions,
            # tool_resources=search_tool.resources,
            headers={"x-ms-enable-preview": "true"},
        )

        print(f"Created agent, ID: {agent.id}")

        # Create thread for communication
        thread = project_client.agents.create_thread()
        print(f"Created thread, ID: {thread.id}")

        # Create message to thread
        message = project_client.agents.create_message(
            thread_id=thread.id,
            role="user",
            content=question,
        )
        print(f"Created message, ID: {message.id}")

        # Create and process agent run in thread with tools
        run = project_client.agents.create_and_process_run(
            thread_id=thread.id, assistant_id=agent.id)
        print(f"Run finished with status: {run.status}")

        print("Agent created and now researching...")
        print('')

        if run.status == "failed":
            print(f"Run failed: {run.last_error}")

         # Fetch run steps to get the details of the agent run
        run_steps = project_client.agents.list_run_steps(
            thread_id=thread.id, run_id=run.id)
        for step in run_steps.data:
            print(f"Step {step['id']} status: {step['status']}")
            step_details = step.get("step_details", {})
            tool_calls = step_details.get("tool_calls", [])

            if tool_calls:
                print("  Tool calls:")
                for call in tool_calls:
                    print(f"    Tool Call ID: {call.get('id')}")
                    print(f"    Type: {call.get('type')}")

                    azure_ai_search_details = call.get("azure_ai_search", {})
                    if azure_ai_search_details:
                        print(
                            f"    azure_ai_search input: {azure_ai_search_details.get('input')}")
                        print(
                            f"    azure_ai_search output: {azure_ai_search_details.get('output')}")
            print()  # add an extra newline between steps

        # Delete the assistant when done
        project_client.agents.delete_agent(agent.id)
        print("Deleted agent")

        # Fetch and log all messages
        messages = project_client.agents.list_messages(thread_id=thread.id)
        print(f"Messages: {messages}")

        try:
            research = {
                "message": messages.data[0]['content'][0]['text']['value']
            }
            print('db research successfully completed')
            return research
        except Exception as ex:
            print(f'db research failed: {str(ex)}')

        return None


@trace
def research(question: str, feedback: str = "No feedback"):
    research = execute_dbresearch(question=question, feedback=feedback)
    print(research)
    return research


if __name__ == "__main__":
    base = Path(__file__).parent

    # Get command line arguments
    if len(sys.argv) < 2:
        question = "Show me the latest market data from Microsoft ?"
    else:
        question = sys.argv[1]

    # Print all environment variables
    print("Environment variables:")
    for key in sorted(os.environ.keys()):
        print(f"{key}={os.environ[key]}")

    feedback = json.loads(Path(base / "dataset.json").read_text())

    research = execute_dbresearch(question=question, feedback=feedback)
    print(json.dumps(research, indent=2))
