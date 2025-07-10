#!/bin/bash
# health_check.sh - Health check script for AWS CodeDeploy EC2 Demo

APP_URL="http://localhost:8000"
HEALTH_ENDPOINT="/health"
TIMEOUT=10

echo "Performing health check for AWS CodeDeploy EC2 Demo..."

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo "ERROR: curl is not installed"
    exit 1
fi

# Perform health check
echo "Checking application health at ${APP_URL}${HEALTH_ENDPOINT}..."

response=$(curl -s -w "%{http_code}" -o /tmp/health_response.json --max-time $TIMEOUT "${APP_URL}${HEALTH_ENDPOINT}")

http_code="${response: -3}"
response_body=$(cat /tmp/health_response.json 2>/dev/null || echo "{}")

if [ "$http_code" = "200" ]; then
    echo "✅ Health check PASSED - HTTP $http_code"
    echo "Response: $response_body"
    exit 0
else
    echo "❌ Health check FAILED - HTTP $http_code"
    echo "Response: $response_body"
    exit 1
fi 