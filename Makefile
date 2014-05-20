#
# docker Makefile -- to run services, commands or clients
#
#  (NOTE: must use real Tabs, not spaces, in a Makefile!)

# "If the .ONESHELL special target appears anywhere in the makefile,
#  then all recipe lines for each target will be provided to a single
#  invocation of the shell..."

# in our Docker images repo...
TAG = biggers/docker-ansible-redis
VERS = latest

DOCKER_IMG = $TAG

# -------- do some Docker
.PHONY: run_redis boot shutdown destroy stats status what_images destroy

# for *updates* to "FROM spec", in the Dockerfile!
build:
	sudo docker build -t ${TAG} .

# ONESHELL works only with 'remake' !! :-P (on Ubuntu)
.ONESHELL:
# forward SSH, Redis and Redmon ports!
run_redis:
	JOB=$$(sudo docker run -d -p 22 -p 6379 -p 4567 -t ${TAG}:${VERS})
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

# -------- CLEAN.UP or debugging

# make destroy JOB=foolish_pandora
destroy: shutdown
	sudo docker rm $$JOB

redmon_build:
	cd /var/tmp/docker-ansible-redis; ansible-playbook ./site.yml --skip-tags=redis -c local --
