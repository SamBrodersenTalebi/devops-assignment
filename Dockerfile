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

# Copy the binary file from previous build stage
COPY --from=build /app/main /app/

# Change the working directory
WORKDIR /app

# expose port 8080 to host 
EXPOSE 8080

# Run the compiled Go app
CMD ["./main"]