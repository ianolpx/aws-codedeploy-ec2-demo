# AWS CodeDeploy EC2 Demo

### Description
This is a demo application for AWS CodeDeploy deployment to EC2 instances. This project demonstrates how to deploy a Python FastAPI application using AWS CodeDeploy with GitHub as the source repository.

### Features
- FastAPI web application with counter functionality
- Automated deployment using AWS CodeDeploy
- Application lifecycle hooks (start/stop)
- Health check endpoint
- Docker containerization support
- Comprehensive logging and monitoring

### Architecture
- **Backend**: Python FastAPI application
- **Deployment**: AWS CodeDeploy with EC2 instances
- **Source**: GitHub repository
- **Runtime**: Python 3.8+ with virtual environment
- **Containerization**: Docker support for local development

### Deployment Process
1. CodeDeploy downloads the application from GitHub
2. Extracts the revision to the target directory
3. Runs ApplicationStop hook to clean up previous deployment
4. Runs ApplicationStart hook to start the new application

### Local Development

#### Prerequisites
- Python 3.8+
- Docker (optional)
- Make (optional)

#### Quick Start
```bash
# Clone the repository
git clone <repository-url>
cd aws-codedeploy-ec2-demo

# Setup development environment
make dev-setup
source venv/bin/activate
make install

# Run the application
make run
```

#### Using Docker
```bash
# Build and run with Docker Compose
make docker-build
make docker-run

# View logs
make docker-logs

# Stop containers
make docker-stop
```

### API Endpoints
- `GET /`: Returns hello message with counter and uptime
- `GET /health`: Health check endpoint for monitoring
- `GET /info`: Application information and status

### Project Structure
```
aws-codedeploy-ec2-demo/
├── app.py                 # Main FastAPI application
├── requirements.txt       # Python dependencies
├── appspec.yml           # AWS CodeDeploy configuration
├── Dockerfile            # Docker container definition
├── docker-compose.yml    # Docker Compose configuration
├── Makefile              # Development automation
├── scripts/
│   ├── applicationStart.sh  # CodeDeploy start hook
│   ├── applicationStop.sh   # CodeDeploy stop hook
│   └── health_check.sh      # Health check script
└── README.md             # This file
```

### AWS CodeDeploy Configuration
The `appspec.yml` file configures:
- Application deployment destination
- File permissions and ownership
- Application lifecycle hooks
- Deployment timeout settings

### Monitoring and Health Checks
- Built-in health check endpoint at `/health`
- Application uptime tracking
- Background counter for demonstration
- Comprehensive logging

### Requirements
- Python 3.8+
- FastAPI
- Uvicorn
- AWS CodeDeploy agent (on target EC2 instances)

### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
