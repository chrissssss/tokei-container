FROM rust:latest

# Install Git and clone tools
RUN apt-get update && \
    apt-get install -y git && \
    cargo install tokei

WORKDIR /app
COPY analyze.sh /app/analyze.sh
RUN chmod +x analyze.sh
