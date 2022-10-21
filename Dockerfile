FROM jenkins/jenkins:latest
MAINTAINER dario696 ddario696@gmail.com
USER root
RUN apt-get update
RUN apt install gradle -y
EXPOSE 8080