# LDAP MySQL Grant Syncher

## Requirements
- bash
- ldapclient (linux)
- MariaDB Client
- MariaDB or MySQL user with admin privileges
- MariaDB or MySQL server with LDAP-pam module configured

## Usage

Configure the Env Variables. We can use the Dockerfile for the Docker-based app, ie:

![image](https://user-images.githubusercontent.com/70002495/179705993-99396aba-8b93-44a5-b123-03b7788f8071.png)

Or, if you have a Kubernetes cluster, simply configure the cronjob.yaml and apply it.

If you don't want to run it as a container, you can use it as a crontab, with exported Envs.
