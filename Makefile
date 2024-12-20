# Variables
IMAGE_NAME = rust_projects
WORKDIR = /usr/src/app

# Default project (override with PROJECT=proj_name)
PROJECT = proj1

# Build the Docker image
build:
	docker build --build-arg PROJECT=$(PROJECT) -t $(IMAGE_NAME) .

# Build the project binary inside the container
build-binary:
	docker run --rm -it -v $(PWD):$(WORKDIR) $(IMAGE_NAME) bash -c "cd $(PROJECT) && cargo build --release"

# Run a specific project's binary
run: build-binary
	docker run --rm -it -v $(PWD):$(WORKDIR) $(IMAGE_NAME) ./$(PROJECT)/target/release/$(PROJECT)

# Run with bind mount for live development
dev:
	docker run --rm -it -v $(PWD):$(WORKDIR) $(IMAGE_NAME) bash

# Clean up Docker image
clean:
	docker rmi $(IMAGE_NAME) --force

# Help message
help:
	@echo "Makefile Commands:"
	@echo "  build         Build the Docker image for the selected project (default: proj1)"
	@echo "               Use 'make build PROJECT=proj2' to build proj2."
	@echo "  build-binary  Build the binary for the selected project inside the container."
	@echo "  run           Run the selected project's binary (default: proj1)"
	@echo "               Use 'make run PROJECT=proj3' to run proj3."
	@echo "  dev           Run the container with a bind mount for interactive use."
	@echo "  clean         Remove the Docker image."
	@echo "  help          Show this help message."

