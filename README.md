# GitHub Action for Kubernetes CLI

This action provides `kubectl` for GitHub Actions.

## Upgrading v2 to v3

Support multiple `commands`, `command` is removed.

## Usage

`.github/workflows/push.yml`

```yaml
on: push
name: deploy
jobs:
  deploy:
    name: deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: deploy to cluster
      uses: steebchen/kubectl@v3
      with: # defaults to latest kubectl binary version
        config: ${{ secrets.KUBE_CONFIG_DATA }}
        commands: |
          apply -f my-app.deployment.yml
          rollout status deployment/my-app
```

## Arguments

`commands` – **required**: The commands you want to run, without `kubectl`, e.g. `get pods`.

`dryrun`: boolean(default `false`), if `--dry-run=client` should be added in the command.

`config` – **required**: A base64-encoded kubeconfig file with credentials for Kubernetes to access the cluster. You can get it by running the following command:

```bash
cat $HOME/.kube/config | base64
```

`version`: The kubectl version with a 'v' prefix, e.g. `v1.21.0`. It defaults to the latest kubectl binary version available.

**Note**: Do not use kubectl config view as this will hide the certificate-authority-data.
