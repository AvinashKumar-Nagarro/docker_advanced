This repository contains a Flask web application that runs inside a Docker container along with Redis for caching. The project uses Docker Compose to orchestrate the services, volumes for persistent data storage, and security practices like dropping unnecessary Linux capabilities.

Step 1: Clone the repository
https://github.com/AvinashKumar-Nagarro/docker_advanced.git

Step 2: Build and run the application
docker-compose up --build

Step 3: Access the application
Open any browser and hit http://localhost:5000

Backup and Restore Volumes
This project uses Docker volumes to persist data, such as application data and Redis data.

Step 1: Back up a volume
docker run --rm -v app_data:/data -v $(pwd):/backup busybox tar czf /backup/app_data.tar.gz /data

Step 2: Restore the volume
docker run --rm -v app_data:/data -v $(pwd):/backup busybox tar xzf /backup/app_data.tar.gz -C /data
