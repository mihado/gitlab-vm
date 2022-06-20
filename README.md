Trying out gitlab using libvirt & docker.

Not entirely working because gitlab-runner.docker executor doesn't play nicely with TLS (even with Let's Encrypt).

I'm gravitating toward the simpler combo (gitea)[https://gitea.io/en-us/] + [tekton](https://tekton.dev/) instead

```sh
# https://docs.gitlab.com/runner/install/docker.html#register-the-runner
# https://docs.gitlab.com/runner/register/index.html#docker
# https://docs.gitlab.com/ee/raketasks/backup_restore.html#reset-runner-registration-tokens

docker-compose exec gitlab-runner gitlab-runner register

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

# https://NbV7GHcuxRNvWGMys2gh@git.int.valiants.co
```
