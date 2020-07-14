FROM golang:1.14-alpine as builder
LABEL maintainer="Narate Ketram <rate@dome.cloud>"
RUN apk --update --no-cache add build-base
WORKDIR /app
ADD . .
RUN go mod download
RUN go build -o /app/http-es-log-server .

FROM alpine
WORKDIR /app
COPY --from=builder /app/http-es-log-server .
EXPOSE 8080
CMD ["/app/http-es-log-server"]

