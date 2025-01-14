![test workflow](https://github.com/cuzfrog/kubectl/actions/workflows/test-action.yml/badge.svg)
# GitHub Action for Kubernetes CLI

This action provides `kubectl` for GitHub Actions.
You many want [setup-kube](https://github.com/cuzfrog/setup-kubectl) for better flexibility.

## Upgrading v2 to v3

Support multiple `commands`, `command` is removed.

## Usage
```yaml
- name: deploy to cluster
  uses: cuzfrog/kubectl@v3
  with: # defaults to latest kubectl binary version
    config: ${{ secrets.KUBE_CONFIG_DATA }}
    dryrun: true
    commands: |
      apply -f my-app.deployment.yml
      rollout status deployment/my-app
```

## Arguments

`commands` – **required**: The commands you want to run, without `kubectl`, e.g. `get pods`.

`config` – **required**: A base64-encoded kubeconfig file with credentials for Kubernetes to access the cluster. You can get it by running the following command:

```bash
cat $HOME/.kube/config | base64
```

`version`: The kubectl version with a 'v' prefix, e.g. `v1.21.0`. It defaults to the latest kubectl binary version available.

`dryrun`: boolean(default `false`), if `--dry-run=client` should be added in the command.


**Note**: Do not use kubectl config view as this will hide the certificate-authority-data.

## Author

Forked from: Luca Steeb <contact@luca-steeb.com>
Maintainer: Cause Chung <cuzfrog@gmail.com>
