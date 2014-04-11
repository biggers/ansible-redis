#
# convenience Makefile, to run services, commands or clients
#
#  (NOTE: must use real tabs, not spaces, in a Makefile!)

# RUNNING targets in this Makefile:
#
#   ONE TIME, do this  (unless you know what you are doing):

# -------- Build it!

TAG=ansible-redis

.PHONY: creat_new_redis
xxx_creat_new_redis:
	JOB=$$(sudo docker run -d -p 22 -p 6379 -t ansible-redis:2.6)
	echo $JOB
	sudo docker ps -a
	sudo docker logs $JOB

# "If the .ONESHELL special target appears anywhere in the makefile,
# then all recipe lines for each target will be provided to a single
# invocation of the shell..."
# make JOB=foolish_pandora start_job
.ONESHELL:
.PHONY: boot
boot:
	sudo docker start $$JOB
	sudo docker ps -a
	sudo docker logs $$JOB | tail -50

# make JOB=foolish_pandora start_job
.ONESHELL:
.PHONY: shutdown
shutdown:
	sudo docker stop $$JOB
	sudo docker logs $$JOB | tail -30

.PHONY: any_status
any_status:
	sudo docker ps -a

.PHONY: what_images
what_images:
	sudo docker images

# -------- CLEAN.UP

.PHONY: clean_job
clean_job:
	sudo docker stop $$JOB
	sudo docker rm $$JOB
	sudo docker ps -a
