# Install the required packages for the func-indexer
if [ ! -d ".venv" ]; then
  python3 -m venv .venv
  echo "Venv created."
else
  echo "The Venv already exists."
fi
 
source .venv/bin/activate 
pip install -r requirements.txt