FROM alpine AS builder

RUN apk add wget \
 && wget -nv https://github.com/helmfile/helmfile/releases/download/v0.155.0/helmfile_0.155.0_linux_amd64.tar.gz \
 && tar xfvz helmfile_0.155.0_linux_amd64.tar.gz

FROM ghcr.io/jenkins-x/jx-boot:3.10.88 AS runner

COPY --from=builder /helmfile /usr/local/bin/helmfile
