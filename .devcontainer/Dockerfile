FROM alpine:latest

# Update package list
RUN apk update

RUN apk --update add git less openssh
RUN apk add openssl-dev cargo

# Install system dependencies for Rust
RUN apk add curl gcc musl-dev openssl-dev pkgconfig
RUN apk add git make cmake

# Install Rust using rustup (recommended method)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source the Rust environment
RUN source ~/.cargo/env

# Add Rust to PATH permanently
RUN echo 'source ~/.cargo/env' >> ~/.bashrc


# Install test runner
RUN cargo install --locked tytanic@0.4.1
RUN cargo install --locked typst-cli

RUN apk add just

CMD ["sh"]