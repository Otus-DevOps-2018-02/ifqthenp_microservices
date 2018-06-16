FROM golang:latest as builder

ENV SRC $GOPATH/src/github.com/prometheus/blackbox_exporter

WORKDIR ${SRC}

RUN git clone "https://github.com/prometheus/blackbox_exporter" "$SRC" \
    && go get -d \
    && go build -o blackbox_exporter

COPY --from=builder /go/src/github.com/prometheus/blackbox_exporter/blackbox_exporter /bin/blackbox_exporter
COPY --from=builder /go/src/github.com/prometheus/blackbox_exporter/blackbox.yml /etc/blackbox_exporter/config.yml
EXPOSE 9115
ENTRYPOINT [ "/bin/blackbox_exporter" ]
CMD [ "--config.file=/etc/blackbox_exporter/config.yml" ]
