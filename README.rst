Redis, Redmon UI by Ansible-created Docker
==========================================

:Author: Mark Biggers <biggers@utsl.com>
:Description: Redis and Redmon dashboard, via an Ansible-managed Docker container
:Ref: `ansible-redis Github project <https://github.com/ICTO/ansible-redis>`_
:Ref: `Docker installation on Ubuntu Linux <http://docs.docker.io/installation/ubuntulinux/>`_
:Ref: `phusion/baseimage for Docker containers <https://github.com/phusion/baseimage-docker#a-minimal-ubuntu-base-image-modified-for-docker-friendliness>`_
:Ref: `Ansible, Getting Started <http://www.ansibleworks.com/docs/gettingstarted.html>`_
:Ref: `Starter examples of Ansible deployments <https://github.com/ansible/ansible-examples>`_
:Ref: `Docker Cheat Sheet <https://gist.github.com/wsargent/7049221>`_
:Ref: `XYZZY <http://magic_happens.com>`_
:Revision: 1.0
:To View: restview README.rst
:Metainfo: `restview, Restructured Text Viewer <https://pypi.python.org/pypi/restview>`_
:Metainfo: `Introductory ReST docs <http://docutils.sf.net/rst.html>`_
:Organization: UTSL.com
:Date: 21 May 2014

-------------------------------------

.. contents:: **Table of Contents**

.. section-numbering::

-------------------------------------

Getting Started
+++++++++++++++
This project provides, within a Docker image and subsequent Docker containers:

1. the ``ansible-redis`` Ansible role - fixed, and updated for 1.6 Ansible, ``baseimage`` and ``runit``
2. a ``Dockerfile`` - which installs, RUN(s) the "latest" Ansible, on that Role
3. uses the Docker image ``phusion/baseimage``, for 14.04 Ubuntu

The ``ansible-redis`` deployment within the container will include:

1. the latest ``redis`` NoSQL DB, from an Ubuntu PPA (package archive)
2. the ``redmon`` dashboard, for Redis, from an Ansible-deployed *Ruby* gem
3. ``runit`` management of these services, via this project's run-scripts

*NOTE: more notes to come; please read the Makefile!*

Install Docker
--------------
Follow any good guide, to install Docker and GNU Make on your Ubuntu system.
(*See the References above; more info is coming*)

Install GNU Make
----------------
::

 sudo apt-get -u install make

Build the Docker image
++++++++++++++++++++++
(*See the References above; more info is coming*)


Build the biggers/docker-ansible-redis image
--------------------------------------------
Use the Makefile, and prosper (*details soon*)
::

 script -c "sudo make build" build.log

Create a working Docker container
+++++++++++++++++++++++++++++++++
(*See the References above*)

Use Make to create a Redis/Redmon container
-------------------------------------------
Use the Makefile, and prosper (*details soon*)
::

 make run_redis

 # OR, to log this run!
 script -c "sudo make run_redis" run.log

Manage the Docker container
+++++++++++++++++++++++++++
(*See the References above*)

Use the Docker cheatsheet, Luke!
--------------------------------
... and use the Makefile, too. ::

 sudo docker ps -a

 # find your Docker container "alias"
 JOB=fracking_bozo

 make stats JOB=$JOB

 make shutdown JOB=$JOB

 make boot JOB=$JOB

 # Login, to the container.  See "ps listing" for SSH, HTTP, Redis service port-forwards
 ssh -p 12345 root@127.0.0.1

 # View the Redmond dashboard; I suggest using Firefox or Chrome instead
 elinks http://127.0.0.1:12350

 sudo docker ps -a

 make destroy JOB=$JOB
