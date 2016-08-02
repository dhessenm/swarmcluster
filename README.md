# swarmcluster
Provisioning Docker swarm cluster with vagrant
Creates three hosts with Docker daemon
* master1
* node1
* node2

Currently you have to configure swarm manually, see [Docker swarm tutorial]( https://docs.docker.com/engine/swarm/swarm-tutorial/)

## Required
* Vagrant
* Ubuntu 14.04 vagrant box (e.g. bento/ubuntu-14.04)
* Ansible

## swarm commands
```
on master: docker swarm init --advertise-addr <IP master1>
on master: docker swarm join-token worker

on worker: docker swarm join ...

docker info
docker node ls

docker service create --name helloworld --replicas 1 alpine ping docker.com

docker service ls
docker service inspect --pretty helloworld

docker service ps helloworld

docker ps

docker service scale helloworld=5

docker service rm helloworld

# Drain a node:
docker node ls
docker service create --replicas 3 --name redis --update-delay 10s redis:3.0.6
docker service ps redis

docker node update --availability drain node2

docker service ps redis

docker node inspect --pretty node2

docker node update --availability active node2
```

Have fun!
