FROM alpine
ARG HELM_VERSION="3.2.1"

RUN apk --no-cache add git bash curl tar && \
    mkdir -p /ci && \
    (cd /usr/local/bin && \
    curl -sSL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz | \
    tar xz --strip-components=1 --strip-components=1 linux-amd64/helm)

COPY docker/entry.sh /entry.sh

WORKDIR /ci
ENTRYPOINT ["/entry.sh"]
