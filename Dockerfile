FROM python:3.11-slim

# Install dependencies if any
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy your script
COPY main.py /main.py

# Set the entrypoint
ENTRYPOINT ["python", "/main.py"]