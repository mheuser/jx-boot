FROM alpine AS helmfile

RUN apk add curl \
 && curl  -o helmfile.tar.gz -L -s https://github.com/helmfile/helmfile/releases/download/v0.167.1/helmfile_0.167.1_linux_amd64.tar.gz \
 && tar xfvz helmfile.tar.gz

FROM releases-docker.jfrog.io/jfrog/jfrog-cli-v2-jf AS jf

FROM ghcr.io/jenkins-x/jx-boot:3.10.154

COPY --from=jf /usr/local/bin/jf /usr/local/bin/jf
COPY --from=helmfile /helmfile /usr/local/bin/helmfile
RUN helm plugin install https://github.com/aslafy-z/helm-git --version 1.3.0
