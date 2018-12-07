Notes from running the pontoon master code on Berlioz.

Rethinking the dockerization approach because the docker-compose approach is dev only. Secrets management and production-ness is missing.

Things that justify that:

- want a production build of the JS code
- don't want the secrets in a .env file in the docker image
- need the front-end code to not just be a forked process but actually "collectstatic" -ified into the django app
- would like to use Udacity best practices for docker images if I can

References that got me to a working Dockerfile:

- https://mozilla-pontoon.readthedocs.io/en/latest/admin/deployment.html#buildpack
- https://www.caktusgroup.com/blog/2017/03/14/production-ready-dockerfile-your-python-django-app/
- their dev-mode Dockerfiles

Note: I'm trying really hard to only have our fork contain new files, i.e. very easy to rebase. It would be even better if it wasn't a fork at all, and part of the build was to clone/pull the latest from the pontoon repo.

## TODO

- figure out django-allauth so we can auth with something other than firefox accounts, could probably use our Google or GitHub in it
- how to specify the GitHub creds (service account username and personal access token as password) so sync can run automatically
  - alternatively we can provide SSH keys somehow, but would consider using varys to manage that
- why doesn't it like our emc-web fluent files?

## Operating

Use https://mozilla-pontoon.readthedocs.io/en/latest/admin/deployment.html#database-migrations to see database migrations and other maintenance tasks.
For now, that will be done by sshing to Berlioz slave and running inside the container to get the env vars and connect to dependencies.
