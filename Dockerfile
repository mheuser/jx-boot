FROM alpine AS helmfile

RUN apk add wget \
 && wget -nv https://github.com/helmfile/helmfile/releases/download/v0.155.0/helmfile_0.155.0_linux_amd64.tar.gz \
 && tar xfvz helmfile_0.155.0_linux_amd64.tar.gz

FROM releases-docker.jfrog.io/jfrog/jfrog-cli-v2-jf AS jf

FROM ghcr.io/jenkins-x/jx-boot:3.10.136

COPY --from=jf /usr/local/bin/jf /usr/local/bin/jf
COPY --from=helmfile /helmfile /usr/local/bin/helmfile
