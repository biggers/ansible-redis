#
# docker Makefile -- to run services, commands or clients
#
#  (NOTE: must use real Tabs, not spaces, in a Makefile!)

# "If the .ONESHELL special target appears anywhere in the makefile,
#  then all recipe lines for each target will be provided to a single
#  invocation of the shell..."

# in our Docker images repo...
TAG = mbiggers/docker-ansible-redis
VERS = 3.0.0

DOCKER_IMG=phusion/baseimage:0.9.10

# -------- do some Docker
.PHONY: run_redis boot shutdown destroy stats status what_images destroy

# for *updates* to "FROM spec", in the Dockerfile!
build:
	ln -s $$HOME/.ssh/authorized_keys authorized_keys_dotssh
	sudo docker build -t ${TAG} .

.ONESHELL:
# ONESHELL works only with 'remake' !! :-P (on Ubuntu)
run_redis:
	JOB=$$(sudo docker run -d -p 22 -p 6379 -t ${TAG}:${VERS})
	echo $$JOB
	sudo docker ps -a
	sudo docker logs $$JOB

# make JOB=foolish_pandora boot
boot:
	sudo docker start $$JOB
	sudo docker ps -a

# make JOB=foolish_pandora shutdown
shutdown:
	sudo docker stop $$JOB
	sudo docker logs $$JOB | tail -30

stats:
	sudo docker ps -a
	sudo docker logs $$JOB

status:
	sudo docker ps -a

what_images:
	sudo docker images

fetch:
	sudo docker pull ${DOCKER_IMG}

# -------- CLEAN.UP

# make destroy JOB=foolish_pandora
destroy: shutdown
	sudo docker rm $$JOB
