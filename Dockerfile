# -*-sh-*-
# ansible-redis/Dockerfile
#
# VERSION    13.10
#
# REFs: 
#   http://www.ansible.com/blog/2014/02/12/installing-and-building-docker-with-ansible
#   https://github.com/wrale/docker-dna
#   https://index.docker.io/u/cohesiveft/haproxy-ssl-ssh/
#   http://docs.docker.io/en/latest/examples/running_redis_service/ 
#   
FROM stackbrew/ubuntu:13.10
MAINTAINER biggers@utsl.com
#
# RUN apt-mark hold upstart \
#   && apt-mark hold initscripts \
#   && dpkg-divert --local --rename --add /sbin/initctl \
#   && rm -f /sbin/initctl \
#   && ln -s /bin/true /sbin/initctl
#
ADD ./apt_mirrors_list /etc/apt/sources.list 
RUN apt-get update
RUN apt-get install -y git python-software-properties software-properties-common runit openssh-server

RUN mkdir -p /etc/service
RUN mkdir -p /var/run/sshd

RUN mkdir -p /root/.ssh
ADD ./authorized_keys_dotssh  /root/.ssh/authorized_keys

# Ensure correct permissions for root/.ssh
RUN  chmod 700 /root/.ssh \
  && chmod 600 /root/.ssh/authorized_keys \
  && chown -R root /root/.ssh

# get the "latest" packaged Ansible
RUN  add-apt-repository -y ppa:rquillo/ansible \
  && apt-get update \
  && apt-get install -y ansible \
  && apt-get clean

# run the Ansible playbook
RUN git clone https://github.com/biggers/ansible-redis.git /var/tmp
ADD hosts /etc/ansible/hosts
WORKDIR /var/tmp/ansible-redis
RUN ansible-playbook ./site.yml -c local
EXPOSE      22 6379

# default command to execute, when creating a new container
CMD /usr/bin/runsvdir -P /etc/service

# EXAMPLE run-command
#   sudo docker run -d -p 2222:22 -p 16379:6379  me/this-image
