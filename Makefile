#
# docker Makefile -- to run services, commands or clients
#
#  (NOTE: must use real Tabs, not spaces, in a Makefile!)

# "If the .ONESHELL special target appears anywhere in the makefile,
#  then all recipe lines for each target will be provided to a single
#  invocation of the shell..."

# in our Docker images repo...
TAG = ansible-redis
VERS = 2.5.1

# -------- do some Docker

.PHONY: run_redis
run_redis:
	JOB=$$(sudo docker run -d -p 22 -p 6379 -t ${TAG}:${VERS})
	echo $$JOB
	sudo docker ps -a
	sudo docker logs $$JOB

# make JOB=foolish_pandora boot
.ONESHELL:
.PHONY: boot
boot:
	sudo docker start $$JOB
	sudo docker ps -a

# make JOB=foolish_pandora shutdown
.PHONY: shutdown
shutdown:
	sudo docker stop $$JOB
	sudo docker logs $$JOB | tail -30

.PHONY: stats
stats:
	sudo docker ps -a
	sudo docker logs $$JOB | tail -30

.PHONY: any_status
any_status:
	sudo docker ps -a

.PHONY: what_images
what_images:
	sudo docker images

# -------- CLEAN.UP

# make JOB=foolish_pandora clean_job
.PHONY: clean_job
clean_job:
	sudo docker stop $$JOB
	sudo docker rm $$JOB
	sudo docker ps -a
