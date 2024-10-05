FROM golang:1.23.1 as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o cicdexample

FROM scratch
COPY --from=builder /app/cicdexample /app
ENTRYPOINT ["/app"]
