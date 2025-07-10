#!/bin/bash
# applicationStart.sh - AWS CodeDeploy EC2 Demo Application Start Script

echo "Starting AWS CodeDeploy EC2 Demo application..."

# Set ownership and permissions
sudo chown -R ssm-user:ssm-user /home/ssm-user/aws-codedeploy-ec2-demo
sudo chmod -R 755 /home/ssm-user/aws-codedeploy-ec2-demo

# Change to application directory
cd /home/ssm-user/aws-codedeploy-ec2-demo

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3.8 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install/upgrade dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Start the application in background
echo "Starting application..."
nohup python app.py > app.log 2>&1 &

# Save PID for later use
echo $! > app.pid

echo "Application started with PID: $(cat app.pid)"
echo "Application logs available at: /home/ssm-user/aws-codedeploy-ec2-demo/app.log"
