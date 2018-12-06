Notes from running the pontoon master code on Berlioz.

Started from the docker-compose usecase and did the following:

- Don't use docker/config/webapp.env as source, instead specify those in berlioz env
- but nothing BUILDS without those! so i plan to inject those from circle, modified Makefile to support more use of `sed` for those in the .env file
- docker build --build-arg SECRET_KEY=\${SECRET_KEY} -t udacity:pontoon -f ./docker/Dockerfile .
- .... I forgot things

## TODO

- frontend node process and python backend process should be separate containers or at least supervised processes that will
  kill the container if either dies, use udacity base and s6
- use udacity base image to get on alpine
- how to get the ENV VARS that are only runtime concerns out of the way so we can BUILD
