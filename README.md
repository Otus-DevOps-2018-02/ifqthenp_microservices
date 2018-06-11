# ifqthenp_microservices

[![Build Status](https://travis-ci.org/Otus-DevOps-2018-02/ifqthenp_microservices.svg?branch=master)](https://travis-ci.org/Otus-DevOps-2018-02/ifqthenp_microservices)

| Emoji | Legend |
| --- | --- |
| :large_blue_diamond: | Main task |
| :large_orange_diamond: | Extra task for self-study |

## HW 13. Containerisation technology. Introduction to Docker

### Completed tasks

- :large_blue_diamond: Installed Docker
- :large_blue_diamond: Run first Docker `hello-world` container
- :large_blue_diamond: Outputted result of `docker images` to `docker-monolith/docker-1.log`
- :large_orange_diamond: Described the difference of Docker image and container in `docker-monolith/docker-1.log`

### Useful commands

- `docker ps` list of running containers
  - `docker ps -a` list all containers
- `docker images` list of saved images
- `docker run -it <image> /bin/bash` create and run container from image
- `docker start <container_id>` run existing container
- `docker attach <container_id>` attach terminal to created container
- `docker exec -it <container_id> bash` runs new process in the container
- `docker commit <container_id>` create image from container
- `docker system df` display information about Docker images, containers, and volumes on the disk
- `docker rm` delete container (add `-f` option to delete running container)
  - `docker rm $(docker ps -a -q)` delete all non-running containers
- `docker rmi` delete image if it has no dependant containers
  - `docker rmi $(docker images -q)` same as above but for all images

### Useful links

- [Docker documentation](https://docs.docker.com/)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [IBM Research Report. An Updated Performance Comparison of Virtual Machines and Linux Containers](https://domino.research.ibm.com/library/cyberdig.nsf/papers/0929052195DD819C85257D2300681E7B/$File/rc25482.pdf)

## HW 14. Docker containers

- :large_blue_diamond: Created docker-host on GCP instance using `docker-machine` command
- :large_blue_diamond: Created Dockerfile with configuration necessary to build `reddit` image
- :large_blue_diamond: Pushed newly built Docker `reddit` image to Docker Hub as `ifqthenp/otus-reddit:1.0`
- :large_orange_diamond: Created Packer template `docker.json` to build an image with preinstalled Docker CE
- :large_orange_diamond: Created Terraform configuration allowing to create several `app` instances (2 by default)
- :large_orange_diamond: Created Ansible playbooks to deploy `ifqthenp/otus-reddit:1.0` application from Docker Hub to GCP instances

### Useful commands

```shell
docker-machine create \
 --driver google \
 --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
 --google-machine-type n1-standard-1 \
 --google-zone europe-west2-a \
 docker-host
 ```

 ```shell
eval $(docker-machine env docker-host)
eval $(docker-machine env -u)
docker-machine ls
docker build -t reddit:latest .
docker run --name reddit -d --network=host reddit:latest
docker login
docker tag reddit:latest <your-login>/otus-reddit:1.0
docker push <your-login>/otus-reddit:1.0
docker logs reddit -f
```

## HW 15. Docker images & microservices

## Completed tasks

- :large_blue_diamond: Added three components to the `src` directory for Reddit application microservices
  - `post-py`
  - `comment`
  - `ui`
- :large_blue_diamond: Created three Dockerfiles for the microservices and optimized Dockerfile commands to reduce image sizes
- :large_blue_diamond: Created three Docker images with `docker build` command
- :large_blue_diamond: Created bridged network `reddit`, assigned network aliases for containers, and launched containers in `reddit` network
- :large_orange_diamond: Stopped running containers and relaunched them with new network aliases and environment variables:
  1. `docker run -d --network=reddit --network-alias=post_db_new --network-alias=comment_db_new mongo:latest`
  2. `docker run -d --network=reddit --network-alias=post_new -e POST_DATABASE_HOST='post_db_new' -e POST_DATABASE='posts_new' ifqthenp/otus-reddit/post:1.0`
  3. `docker run -d --network=reddit --network-alias=comment_new -e COMMENT_DATABASE_HOST='comment_db_new' -e COMMENT_DATABASE='comments_new' ifqthenp/otus-reddit/comment:1.0`
  4. `docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST='post_new' -e COMMENT_SERVICE_HOST='comment_new' ifqthenp/otus-reddit/ui:1.0`
- :large_orange_diamond: Created new images based on Linux Alpine and applied best practices to reduce image sizes for `post-py`, `comment`, and `ui` microservices. New pull request has been created on separate branch `docker-3-alpine`

### Useful links

- [hadolint: Dockerfile linter, validate inline bash, written in Haskell](https://github.com/hadolint/hadolint)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

## HW 16. Docker networking & docker-compose

### Completed tasks

- :large_blue_diamond: Launched number of containers with different Docker network drivers: `none`, `host`, and `bridge`
- :large_blue_diamond: Explored Docker networking functionality using `joffotron/docker-net-tools` container with pre-installed networking utilities
- :large_blue_diamond: Created `front_net` and `back_net` networks for Reddit application. Connected `post` and `comment` containers to both networks
- :large_blue_diamond: Created `docker-compose.yml` file and transposed `docker container` commands with networks and network aliases to Compose format
- :large_blue_diamond: Populated default values referenced in the Compose file using environment variables set in `.env` file
- :large_orange_diamond: Default project name for Compose can be set in `.env` file using Compose environment variable `COMPOSE_PROJECT_NAME`. Alternatively, it can be set using `-p` command-line option
- :large_orange_diamond: Created `docker-compose.override.yml` file to launch Ruby applications on Puma server in debug mode with 2 workers

### Docker commands

- `docker run -d --network=front_net -p 9292:9292 --name ui <your-login>/ui:1.0`
- `docker run -d --network=back_net --name comment <your-login>/comment:1.0`
- `docker run -d --network=back_net --name post <your-login>/post:1.0`
- `docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db mongo:latest`
- `docker network create back_net --subnet=10.0.2.0/24`
- `docker network create front_net --subnet=10.0.1.0/24`
- `docker network connect front_net post`
- `docker network connect back_net post`
- `docker-compose -f docker-compose.yml`
- `docker-compose ps`

## HW 17. GitLab CI: Building Continuous Integration Pipeline

### Completed tasks

- :large_blue_diamond: created folder `gitlab-infra` with infrastructure code using Packer, Terraform, and Ansible to automate GitLab deployment with Docker
- :large_blue_diamond: in GitLab CE created `homework` group with `example` project in it
- :large_blue_diamond: defined CI/CD pipeline in `.gitlab-ci.yml`
- :large_blue_diamond: registered runner for the project
- :large_blue_diamond: added `reddit` monolith application into the repo
- :large_blue_diamond: redefined CI/CD pipeline for testing `reddit` monolith app
- :large_orange_diamond: integrated GitLab with Slack notifications

### How to launch the project

1. `cd` into `gitlab-infra` folder
2. Run `packer build -var-file=packer/variables.json packer/gitlab.json` if you need to build an image with Docker and Docker Compose preinstalled
3. `cd` into `terraform/bucket` folder and run `terraform init` to initialise storage for Terraform state
4. `cd` into `terraform` folder
5. Run `terraform init`, `terraform plan`, and `terraform apply` to create GCE instance based on previously Packer-built image
6. `cd` into `ansible` folder
7. Run `ansible-playbook playbooks/gitlab-setup.yml` to complete GitLab CI setup
8. Wait for couple of minutes for GitLab initial configuration to finalize
9. Use GCE instance external IP to access GitLab's CI web interface

### Useful commands

Change remote's URL in `.git/config`

```shell
git remote set-url gitlab http://<GCE PUBLIC IP>/homework/example.git
```

Register Runner on GitLab CI host

```shell
docker run -d --name gitlab-runner --restart always \
-v /srv/gitlab-runner/config:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest
```

```shell
docker exec -it gitlab-runner gitlab-runner register
```

## HW 18. GitLab CI: Continuous Delivery

### Completed tasks

- :large_blue_diamond: Created new project `example2` in Gitlab CE and enabled `gitlab runner` for that project
- :large_blue_diamond: Added `dev`, `staging`, and `production` environments
- :large_blue_diamond: Added `when:manual` parameter to `staging` and `production` environments
- :large_blue_diamond: Added `only` parameter to set job policy to limit when job is created
- :large_blue_diamond: Added dynamic environments using GitLab environment variables

## HW 19. Introduction to monitoring. Monitoring systems

### Completed tasks

- :large_blue_diamond: Created GCE instance `docker-host` using `docker-machine` command for the Reddit and Prometheus containers
- :large_blue_diamond: Launched Prometheus container built from `prom/prometheus:v2.1.0` to learn about the UI and basic Prometheus metrics
- :large_blue_diamond: Created new image `$(USER_NAME)/prometheus` built using `prom/prometheus:v2.1.0` with custom config provided in `prometheus.yml`
- :large_blue_diamond: Built images for the Reddit app services using `docker_build.sh` scripts provided in `ui`, `post-py`, and `comment` folders
- :large_blue_diamond: Added `prometheus` service to the Compose file and launched microservices using `docker-compose up -d` command
- :large_blue_diamond: Using Prometheus web interface inspected services' health status, stopped some services to check Prometheus status codes and relaunched the services again to make sure that all services are healthy
- :large_blue_diamond: Added `node-exporter` service to the Compose file, added `node` job to the `prometheus.yml`, and rebuilt `$(USER_NAME)/prometheus` image
- :large_blue_diamond: Pushed images used in this homework to the Docker Hub
- :large_orange_diamond: Added Dockerfile to `docker/mongodb_exporter` folder to build Docker image and added `mongodb` job to `prometheus.yml` for MongoDB monitoring service
- :large_orange_diamond: Added Dockerfile to `docker/blackbox_exporter` folder to build Docker image and added `blackbox` job with `http_2xx` module to `prometheus.yml` to monitor HTTP for `comment`, `ui`, and `post` microservices
- :large_orange_diamond: Created Makefile that can build all images need for this homework and can push them to Docker Hub

## HW 20. Monitoring of application and infrastructure

### Completed tasks

- :large_blue_diamond: Installed Google's cAdvisor resource analyser on Docker container to collect metrics about services
- :large_blue_diamond: Installed and configured Grafana analytics platform for collected metrics
- :large_blue_diamond: Created and imported various dashboards in Grafana including histogram and percentile metrics from Prometheus
- :large_blue_diamond: Set up alerting rules for Alertmanager from Prometheus and configured Slack notifications
- :large_orange_diamond: Added rules for new images to the `Makefile`
- :large_orange_diamond: Set up experimental Docker daemon metrics collection in Prometheus format
- :large_orange_diamond: Set up InfluxDB Telegraf for Docker daemon metrics collection
- :large_orange_diamond: Configured Alertmanager to send email notifications

## HW 21. Logging and distributed tracing

### Completed tasks

- :large_blue_diamond: Configured and launched centralised EFK logging system:
  - ElasticSearch (searching engine for log data)
  - Fluentd (logs aggregator)
  - Kibana (visualisation of logged data)
- :large_blue_diamond: Configured `post` and `ui` services to send logs to Fluentd service using Docker `fluentd` driver
- :large_blue_diamond: Launched Zipkin distributed tracing service and analysed the traces of services using Zipkin Web UI
- :large_orange_diamond: Configured Fluentd service to parse unstructured logs received from `ui` service with `grok` parser

### Useful commands

```shell
docker-machine create --driver google \
  --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
  --google-machine-type n1-standard-1 \
  --google-disk-size 20 \
  --google-open-port 5601/tcp \
  --google-open-port 9292/tcp \
  --google-open-port 9411/tcp \
  docker-host
```

### Useful links

[The Twelve-Factor App](https://12factor.net/)

## HW 22. Introduction to Kubernetes

### Completed tasks

- :large_blue_diamond: Created `yml` files in `kubernetes/reddit` folder with Deployment manifests for Reddit application:
  - `ui-deployment.yml`
  - `comment-deployment.yml`
  - `post-deployment.yml`
  - `mongo-deployment.yml`
- :large_blue_diamond: Successfully completed [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) tutorial from Kelsey Hightower
- :large_blue_diamond: Successfully tested Reddit application deployment to the Kubernetes cluster with `kubectl -f <filename>` command
