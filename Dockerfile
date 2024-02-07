FROM golang:alpine AS builder
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update && apk --no-cache add build-base
WORKDIR /go/src/github.com/bxfxf/livetv/
COPY . . 
ENV CGO_CFLAGS=-D_LARGEFILE64_SOURCE
RUN GOPROXY="https://goproxy.io" GO111MODULE=on go build -o livetv .

FROM alpine:latest
RUN apk --no-cache add ca-certificates youtube-dl tzdata libc6-compat libgcc libstdc++
WORKDIR /root
COPY --from=builder /go/src/github.com/bxfxf/livetv/view ./view
COPY --from=builder /go/src/github.com/bxfxf/livetv/assert ./assert
COPY --from=builder /go/src/github.com/bxfxf/livetv/.env .
COPY --from=builder /go/src/github.com/bxfxf/livetv/livetv .
EXPOSE 9000
VOLUME ["/root/data"]
CMD ["./livetv"]