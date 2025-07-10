.PHONY: help install run test clean docker-build docker-run docker-stop

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dependencies
	pip install -r requirements.txt

run: ## Run the application locally
	python app.py

test: ## Run tests (placeholder)
	@echo "Tests not implemented yet"

clean: ## Clean up generated files
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	rm -rf *.log app.pid

docker-build: ## Build Docker image
	docker build -t aws-codedeploy-ec2-demo .

docker-run: ## Run application in Docker
	docker-compose up -d

docker-stop: ## Stop Docker containers
	docker-compose down

docker-logs: ## View Docker logs
	docker-compose logs -f

dev-setup: ## Setup development environment
	python -m venv venv
	@echo "Virtual environment created. Activate it with: source venv/bin/activate"
	@echo "Then run: make install"

deploy-local: ## Deploy locally (simulate CodeDeploy)
	@echo "Stopping existing application..."
	@if [ -f app.pid ]; then kill $$(cat app.pid) 2>/dev/null || true; fi
	@echo "Starting application..."
	make run 