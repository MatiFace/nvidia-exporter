FROM golang:1.9.2 as builder

RUN apt-get update -y && apt-get install -y build-essential git
RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR /go/src/github.com/bugroger/nvidia-exporter
COPY . .

#RUN dep ensure -vendor-only

ARG VERSION
RUN make all

FROM nvidia/cuda:9.0-cudnn7-runtime

COPY --from=builder /go/src/github.com/bugroger/nvidia-exporter/bin/linux/* /

ENTRYPOINT ["/nvidia-exporter"]
