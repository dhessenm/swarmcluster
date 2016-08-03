# swarmcluster
Provisioning Docker swarm cluster with vagrant
Creates three hosts with Docker daemon
* swarm-manager1
* swarm-worker1
* swarm-worker2

## Installation
Bring up vagrants hosts
```vagrant up```

Check if all vagrants hosts are running

```vagrant status```

Login into swarm-manager1

```vagrant ssh swarm-manager1```

Provision Docker swarm cluster with ansible playbook

```
cd /vagrant/Provision
ansible-playbook all.yml
```

## swarm commands
on manager node: docker swarm init --advertise-addr <IP master1>
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

### Drain a node:
docker node ls
docker service create --replicas 3 --name redis --update-delay 10s redis:3.0.6
docker service ps redis

docker node update --availability drain node2

docker service ps redis

docker node inspect --pretty node2

docker node update --availability active node2

# Links
[Docker swarm tutorial]( https://docs.docker.com/engine/swarm/swarm-tutorial/)

[Docker blog docker 1.12 build in orchestration
](https://blog.docker.com/2016/06/docker-1-12-built-in-orchestration/)


Have fun!
