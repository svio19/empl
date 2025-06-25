
#!/bin/sh

# Exit on any error
set -e

echo "Starting React application..."

# Check if build directory exists
if [ ! -d "build" ]; then
    echo "Build directory not found. Running npm run build..."
    npm run build
fi

# Start the application
echo "Serving React app on port 3000..."
exec serve -s build -l 3000