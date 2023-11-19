FROM alpine:latest as base
ARG VERSION

FROM base AS cache

WORKDIR /temp

ARG TARGETARCH
ARG TARGETOS

RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_${VERSION}_linux_${TARGETARCH}.zip
RUN unzip pocketbase_${VERSION}_linux_${TARGETARCH}

FROM base AS prod

WORKDIR /usr/src/app

COPY --from=cache /temp/pocketbase /usr/src/app

ENTRYPOINT [ "./pocketbase" ]
CMD ["serve", "--http", "0.0.0.0:8989"]