from threading import Thread
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
import sched
import time
import uvicorn
import os
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="AWS CodeDeploy EC2 Demo",
    description="A demo FastAPI application for AWS CodeDeploy deployment",
    version="1.0.0"
)

s = sched.scheduler(time.time, time.sleep)

count = 0
start_time = None

@app.get("/")
async def root():
    """Root endpoint returning hello message and counter"""
    global count
    return {
        "message": "Hello from AWS CodeDeploy EC2 Demo!",
        "count": count,
        "uptime": get_uptime(),
        "timestamp": datetime.now().isoformat()
    }

@app.get("/health")
async def health_check():
    """Health check endpoint for monitoring"""
    return {
        "status": "healthy",
        "uptime": get_uptime(),
        "count": count,
        "timestamp": datetime.now().isoformat()
    }

@app.get("/info")
async def app_info():
    """Application information endpoint"""
    return {
        "app_name": "AWS CodeDeploy EC2 Demo",
        "version": "1.0.0",
        "environment": os.getenv("ENVIRONMENT", "development"),
        "uptime": get_uptime(),
        "count": count
    }

def get_uptime():
    """Calculate application uptime"""
    if start_time:
        return time.time() - start_time
    return 0

def count_event(sc=None):
    """Background task to increment counter every 5 seconds"""
    global count
    count += 1
    logger.info(f"Counter incremented to: {count}")
    if sc:
        sc.enter(5, 1, count_event, (sc,))
        sc.run()

@app.on_event("startup")
async def startup_event():
    """Application startup event"""
    global start_time
    start_time = time.time()
    logger.info("Application starting up...")
    
    # Start background counter thread
    thread = Thread(target=count_event, kwargs=dict(sc=s))
    thread.daemon = True
    thread.start()
    logger.info("Background counter thread started")

@app.on_event("shutdown")
async def shutdown_event():
    """Application shutdown event"""
    logger.info("Application shutting down...")

if __name__ == '__main__':
    logger.info("Starting AWS CodeDeploy EC2 Demo application...")
    uvicorn.run(app, host="0.0.0.0", port=8000, log_level="info")
