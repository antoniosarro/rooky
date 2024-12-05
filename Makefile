VERSION=$(shell cat version)
BINARY_NAME=rooky-$(VERSION)

build:
	go build -o $(BINARY_NAME) cmd/rooky/main.go

run:
	go run cmd/rooky/main.go

clean:
	rm -f $(BINARY_NAME)
