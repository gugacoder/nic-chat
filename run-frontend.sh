#!/bin/bash
# Script to run the frontend from source

# Install npm dependencies
echo "Installing npm dependencies..."
npm install

# Start the development server on port 3000
echo "Starting frontend server on port 3000..."
npm run dev -- --port 3000
