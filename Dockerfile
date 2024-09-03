FROM alpine AS helmfile

RUN apk add curl \
 && curl  -o helmfile.tar.gz -L -s https://github.com/helmfile/helmfile/releases/download/v1.0.0-rc.4/helmfile_1.0.0-rc.4_linux_amd64.tar.gz \
 && tar xfvz helmfile.tar.gz

FROM releases-docker.jfrog.io/jfrog/jfrog-cli-v2-jf AS jf

FROM ghcr.io/jenkins-x/jx-boot:3.10.154

COPY --from=jf /usr/local/bin/jf /usr/local/bin/jf
COPY --from=helmfile /helmfile /usr/local/bin/helmfile
