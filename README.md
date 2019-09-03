# Build Your Own Telegraf

Telegraf isn't a huge binary, it's under 100MiB (Docker Images are rougly 250MiB). However, we can make that smaller.

Telegraf ships with A LOT of plugins for supporting all of our users use-cases, but each individidual user only needs around 4/5 plugins.

This tooling aims to make it as simple as pie to build your own custom Telegraf Docker image.

## Requirements

You need Docker

## Getting Started

### Telegraf Config

You should have a local directory in the root of your build context called `telegraf` with your configuration. This would be what you have in `/etc/telegraf/` on any other deployment.

### Dockerfile

Provide a Dockerfile. You can use any base layer you want, even scratch. I'm using Alpine.

```Dockerfile
FROM rawkode/telegraf:byo AS build

FROM alpine:3.7 AS telegraf

COPY --from=build /etc/telegraf /etc/telegraf
COPY --from=build /go/src/github.com/influxdata/telegraf/telegraf /bin/telegraf
ENTRYPOINT [ "/bin/telegraf" ]
```

### Build Docker Image

`docker image build --tag your_image_name --build-arg VERSION=1.10 .`
