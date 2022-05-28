FROM alpine

LABEL version="3"
LABEL name="kubectl"
LABEL repository="http://github.com/cuzfrog/kubectl"
LABEL homepage="http://github.com/cuzfrog/kubectl"

LABEL maintainer="Luca Steeb <contact@luca-steeb.com>, Cause Chung <cuzfrog@gmail.com>"
LABEL com.github.actions.name="Kubernetes CLI - kubectl"
LABEL com.github.actions.description="Runs kubectl. The config can be provided with the secret KUBE_CONFIG_DATA."
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="blue"

RUN apk add --no-cache curl

COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
