#!/bin/bash

param1=$1

# sleep
s=1

usage () 
{
  echo "Usage: $0 [ reset | leave | join | init | state ]"
}



case $param1 in
  reset)
     ansible-playbook manage-swarm.yml --limit swarm-worker --tags="leave"
     ansible-playbook manage-swarm.yml --limit swarm-manager --tags="leave"
     echo "sleep $s s"
     sleep $s
     ansible-playbook manage-swarm.yml --limit swarm-manager --tags="init"
     ansible-playbook manage-swarm.yml --tags="join"
     ;;
  leave)
     ansible-playbook manage-swarm.yml --limit swarm-worker --tags="leave"
     ansible-playbook manage-swarm.yml --limit swarm-manager --tags="leave"
     ;;
  join)
     ansible-playbook manage-swarm.yml --tags="join"
     ;;
  init)
     ansible-playbook manage-swarm.yml --limit swarm-manager --tags="init"
     ;;
  status)
     ansible-playbook manage-swarm.yml --limit swarm-manager --tags="status"
     ;;
  *)
     usage
     ;;
esac


