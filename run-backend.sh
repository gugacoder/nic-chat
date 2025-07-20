#!/bin/bash
# Script to run the backend from source

# Navigate to the backend directory
cd backend

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate the virtual environment
source venv/bin/activate

# Install dependencies
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

# Run the development server
echo "Starting backend server on port 8000..."
./dev.sh
