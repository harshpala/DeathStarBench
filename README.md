# DeathStarBench - Social Network Setup

This document provides step-by-step instructions on setting up and running the Social Network microservices from the DeathStarBench suite.

## Overview of DeathStarBench - Social Network
DeathStarBench is a benchmark suite for microservices-based applications. The Social Network component simulates a real-world social networking service, including user interactions such as:
- User registration and authentication
- Posting and reading timelines
- Following/unfollowing users
- Building social graphs

### Architecture Overview
The Social Network is composed of multiple microservices, including:
- **User Service**: Handles authentication and user management.
- **Post Service**: Manages user posts.
- **Timeline Service**: Generates personalized home and user timelines.
- **Social Graph Service**: Maintains follower/following relationships.
- **MongoDB**: Stores user and post data.
- **NGINX**: Serves as an API gateway for requests.

The services communicate using REST APIs and are deployed using Docker containers.

## Prerequisites
Ensure you have the following installed:
- Docker & Docker Compose
- Python 3 (with `venv` support)
- Required system dependencies:
  ```bash
  sudo apt update && sudo apt install -y python3-aiohttp luajit luasocket libssl-dev make
  ```

## 1. Clone the Repository
```bash
git clone --recurse-submodules https://github.com/your-repo/DeathStarBench.git
cd DeathStarBench/socialNetwork
```

## 2. Start Services Using Docker Compose
```bash
docker compose up -d
```
Check running containers:
```bash
docker ps
```

## 3. Access MongoDB and Verify Users
Enter the MongoDB container:
```bash
docker exec -it socialnetwork-user-mongodb-1 mongosh
```
Check available databases:
```bash
show dbs
```
Check existing users:
```bash
use user
db.user.find().pretty()
```

## 4. Register Users & Construct Social Graph
Run the script to initialize a social graph:
```bash
python3 scripts/init_social_graph.py --graph=socfb-Reed98
```
If you get a `ModuleNotFoundError` for `aiohttp`, install it in a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
pip install aiohttp
```
Then retry running the script.

## 5. Build the Workload Generator
Ensure dependencies are installed, then build:
```bash
cd ../wrk2
make
cd ../socialNetwork
```

## 6. Run Workload Generators
- **Compose Posts**
  ```bash
  ../wrk2/wrk -D exp -t 12 -c 400 -d 300 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R 10
  ```
- **Read Home Timelines**
  ```bash
  ../wrk2/wrk -D exp -t 12 -c 400 -d 300 -L -s ./wrk2/scripts/social-network/read-home-timeline.lua http://localhost:8080/wrk2-api/home-timeline/read -R 10
  ```
- **Read User Timelines**
  ```bash
  ../wrk2/wrk -D exp -t 12 -c 400 -d 300 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://localhost:8080/wrk2-api/user-timeline/read -R 10
  ```

## 7. Debugging & Common Issues
- **MongoDB Not Found**: Ensure the container is running with `docker ps`.
- **Missing Python Packages**: Use a virtual environment (`venv`) to install required dependencies.
- **Build Errors in `wrk2`**: Ensure `make` and dependencies (`libssl-dev`) are installed.

## 8. Stopping and Cleaning Up
To stop all services:
```bash
docker compose down
```
To remove all volumes and clean up:
```bash
docker compose down -v
```

## Next Steps
- Test API endpoints with Postman or `curl`
- Modify configurations for performance tuning
- Scale services using Kubernetes
- Benchmarking and Profiling Performance Across Multiple Machine Configurations

## Goal

The primary objective of this project is to gain hands-on experience in profiling, deploying, and integrating microservices within a Docker and Kubernetes-hosted environment. The project involves deploying the system across multiple machines with varying configurations to benchmark and analyze performance metrics effectively.

This process will help in:

- Profiling system performance under different hardware and software environments.
- Optimizing resource utilization for efficient microservices execution.
- Ensuring seamless deployment and integration using containerized solutions.

By leveraging Docker and Kubernetes, the project aims to simulate real-world deployment scenarios and evaluate system scalability, reliability, and performance.

## Additional Documentation

For more detailed information, please refer to the following documents:

- **[Creativity](creativity.md)** - Creative approaches and innovative solutions implemented in the project
- **[Deployment](deployment.md)** - Detailed deployment instructions and configurations
- **[Microservices Architecture Breakdown](Microservices_Architecture_Breakdown.md)** - Comprehensive analysis of the microservices architecture
- **[Social Network README](socialNetwork/README.md)** - Detailed documentation for the Social Network microservices
- **[Helm Chart README](socialNetwork/helm-chart/README.md)** - Automate the process of deploying Social Network Microservices on a Kubernetes cluster natively using Helm chart

---


