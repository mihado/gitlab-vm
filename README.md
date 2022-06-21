Trying out gitlab using libvirt & docker.

Not entirely working because gitlab-runner.docker executor doesn't play nicely with TLS (even with Let's Encrypt).

```sh
# https://docs.gitlab.com/runner/install/docker.html#register-the-runner
# https://docs.gitlab.com/runner/register/index.html#docker
# https://docs.gitlab.com/ee/raketasks/backup_restore.html#reset-runner-registration-tokens

# shell: easiest
#
# docker: need pre-built image that trust our SSL & access to token
#
# https://docs.gitlab.com/runner/configuration/advanced-configuration.html#how-clone_url-works
# https://docs.gitlab.com/runner/configuration/tls-self-signed.html#docker
# https://docs.gitlab.com/ee/security/token_overview.html#runner-authentication-tokens-also-called-runner-tokens
# https://docs.gitlab.com/ee/ci/jobs/ci_job_token.html

# Open issue (job token cannot access internal job)
# https://gitlab.com/gitlab-org/gitlab/-/issues/333444

# shell runner
sudo gitlab-runner register -n \
  --url https://git.int.valiants.co/ \
  --registration-token TOKEN \
  --executor shell \
  --description "runner-metal-shell"

# docker not working properly !!!
sudo gitlab-runner register -n \
  --url https://git.int.valiants.co/ \
  --registration-token TOKEN \
  --executor docker \
  --description "runner-metal-dind" \
  --docker-image "docker:20.10.16" \
  --docker-privileged \
  --docker-volumes "/certs/client"

docker-compose exec gitlab-runner gitlab-runner register

docker-compose exec gitlab-runner gitlab-runner register \
  --url https://git.int.valiants.co/ \
  --registration-token TOKEN \
  --executor docker \
  --description "runnder-docker-dind" \
  --docker-image "docker:20.10.16" \
  --docker-privileged \
  --docker-volumes "/certs/client"
```
