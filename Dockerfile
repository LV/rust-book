# Use the official Rust image
FROM rust:latest

# Set a working directory in the container
WORKDIR /usr/src/app

# Copy all projects into the container
COPY . .

# Default project to build (can be overridden)
ARG PROJECT=guessing_game

# Build the specified project
RUN cd $PROJECT && cargo build --release

# Default command to run the built binary
CMD ["bash"]
