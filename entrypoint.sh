#!/bin/bash

set -e

version="$1"
config="$2"
dryrun="$3"
commands="$4"

if [ "$version" = "latest" ]; then
  version=$(curl -Ls https://dl.k8s.io/release/stable.txt)
fi

if [ "$dryrun" = "true" ]; then
  dryrun="--dry-run=client"
else
  dryrun=""
fi

readarray -t cmdArr <<<"$commands"

echo "using kubectl@$version"

curl -sLO "https://dl.k8s.io/release/$version/bin/linux/amd64/kubectl" -o kubectl
chmod +x kubectl
mv kubectl /usr/local/bin

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$config" | base64 -d > /tmp/config
export KUBECONFIG=/tmp/config

arraylength=${#cmdArr[@]}
for (( i=0; i<${arraylength}; i++ ));
do
  command=${cmdArr[$i]}
  if [ ! -z "$command" ]; then
    execCmd="kubectl $dryrun $command"
    echo $execCmd
    sh -c "$execCmd"
  fi
done
