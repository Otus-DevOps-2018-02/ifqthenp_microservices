# ifqthenp_microservices

[![Build Status](https://travis-ci.org/Otus-DevOps-2018-02/ifqthenp_microservices.svg?branch=master)](https://travis-ci.org/Otus-DevOps-2018-02/ifqthenp_microservices)

| Emoji | Legend |
| --- | --- |
| :large_blue_diamond: | Main task |
| :large_orange_diamond: | Extra task for self-study |
| :diamonds: | Homework delimiter |

## :diamonds: HW 13. Containerisation technology. Introduction to Docker

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

## :diamonds: HW 14. Docker containers

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
