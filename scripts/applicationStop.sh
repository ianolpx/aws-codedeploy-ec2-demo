#!/bin/bash
# applicationStop.sh - AWS CodeDeploy EC2 Demo Application Stop Script

echo "Stopping AWS CodeDeploy EC2 Demo application..."

# Check if application directory exists
if [ -d /home/ssm-user/aws-codedeploy-ec2-demo ]; then
    echo "Cleaning up previous deployment..."
    sudo rm -rf /home/ssm-user/aws-codedeploy-ec2-demo
fi

# Create fresh application directory
echo "Creating fresh application directory..."
sudo mkdir -vp /home/ssm-user/aws-codedeploy-ec2-demo

# Find and kill running application processes
PID=$(pgrep -f "python.*app.py")

if [ -n "$PID" ]; then
    echo "Found running application with PID: $PID"
    echo "Sending SIGTERM to process..."
    sudo kill -15 $PID
    
    # Wait for graceful shutdown
    sleep 5
    
    # Check if process is still running
    if kill -0 $PID 2>/dev/null; then
        echo "Process still running, sending SIGKILL..."
        sudo kill -9 $PID
    fi
    
    echo "Application stopped successfully"
else
    echo "No running application found"
fi

# Clean up any remaining PID files
if [ -f /home/ssm-user/aws-codedeploy-ec2-demo/app.pid ]; then
    rm -f /home/ssm-user/aws-codedeploy-ec2-demo/app.pid
fi

echo "Application stop process completed"
