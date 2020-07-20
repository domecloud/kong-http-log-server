FROM golang:1.14-alpine as builder
LABEL maintainer="Narate Ketram <rate@dome.cloud>"
RUN apk --update --no-cache add build-base
WORKDIR /app
ADD . .
RUN go mod download
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/kong-http-log-server .

FROM alpine
WORKDIR /app
COPY --from=builder /app/kong-http-log-server .
EXPOSE 8080
ENTRYPOINT ["/app/kong-http-log-server"]

