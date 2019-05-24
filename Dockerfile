FROM golang:alpine

RUN apk add --update git dep make

COPY ./gen.go /code/gen.go

ONBUILD ARG VERSION

ONBUILD RUN git clone --depth 1 -b release-${VERSION} https://github.com/influxdata/telegraf /go/src/github.com/influxdata/telegraf
ONBUILD WORKDIR /go/src/github.com/influxdata/telegraf

ONBUILD RUN cp /code/gen.go /go/src/github.com/influxdata/telegraf/gen.go
ONBUILD RUN make deps
ONBUILD COPY telegraf /etc/telegraf
ONBUILD RUN go run gen.go
ONBUILD RUN make static
