import asyncio
import json
import os
import sys
from pathlib import Path

import prompty
from azure.ai.agents.models import ListSortOrder, MessageTextContent
from azure.ai.inference.prompts import PromptTemplate
from azure.ai.projects.aio import AIProjectClient
from azure.identity import DefaultAzureCredential
from dotenv import load_dotenv
from prompty.tracer import trace

load_dotenv()

# Create an Azure AI Client from a connection string, copied from your Azure AI Foundry project.
# At the moment, it should be in the format "<HostName>;<AzureSubscriptionId>;<ResourceGroup>;<HubName>"
# Customer needs to login to Azure subscription via Azure CLI and set the environment variables


@trace
async def execute_dbresearch(question: str, feedback: str = "No feedback"):

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
    agent = await project_client.agents.create_agent(
        model="gpt-4.1",
        name="code-researcher",
        instructions=messages[0]['content'],
        # tools=search_tool.definitions,
        # tool_resources=search_tool.resources,
        headers={"x-ms-enable-preview": "true"},
    )

    print(f"Created agent, ID: {agent.id}")

    # Create thread for communication
    thread = await project_client.agents.threads.create()
    print(f"Created thread, ID: {thread.id}")

    # Create message to thread
    message = await project_client.agents.messages.create(
        thread_id=thread.id,
        role="user",
        content=question,
    )
    print(f"Created message, ID: {message.id}")

    # Create and process agent run in thread with tools
    run = await project_client.agents.runs.create(
        thread_id=thread.id, agent_id=agent.id)
    print(f"Run finished with status: {run.status}")

    print("Agent created and now researching...")
    print('')

    # Poll the run as long as run status is queued or in progress
    while run.status in ["queued", "in_progress", "requires_action"]:
        # Wait for a second
        await asyncio.sleep(1)
        run = await project_client.agents.runs.get(
            thread_id=thread.id, run_id=run.id)
        print(f"Run status: {run.status}")

    if run.status == "failed":
        print(f"Run failed: {run.last_error}")

    # Delete the assistant when done
    await project_client.agents.delete_agent(agent.id)
    print("Deleted agent")

    # Fetch and log messages
    messages = project_client.agents.messages.list(
        thread_id=thread.id, order=ListSortOrder.ASCENDING)
    async for msg in messages:
        last_part = msg.content[-1]
        if isinstance(last_part, MessageTextContent):
            print(f"{msg.role}: {last_part.text.value}")

    try:
        msgs = [msg async for msg in messages]
        if not msgs:
            print('db research failed: no messages returned')
            return {"message": "No messages returned from agent."}
        research = {
            "message": msgs[0]['content'][0]['text']['value']
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

    research = asyncio.run(execute_dbresearch(
        question=question, feedback=feedback))
    print(json.dumps(research, indent=2))
