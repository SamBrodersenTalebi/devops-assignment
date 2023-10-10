# Use GO runtime as parent image
FROM golang:1.19-alpine as build

WORKDIR /app

# Copy local packages to container WORKDIR
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download


# Copy the source code files host to image filesystem.
COPY . .

# Build the Go app name the built binary main
RUN GOOS=linux go build -o main .


FROM alpine:3.14

# Install Redis
RUN apk add --no-cache redis

# Copy the binary file from previous build stage
COPY --from=build /app/main /app/

# Copy Redis configuration
COPY redis.conf /etc/redis.conf

# Change the working directory
WORKDIR /app

# expose port 4444 to host where go app is running
EXPOSE 4444

# Run the compiled Go app and redis-server
# Specify redis data directory --dir /var/lib/redis
CMD ["sh", "-c", "redis-server /etc/redis.conf & ./main"]