FROM rust:latest

# Install Git, jq, Python
RUN apt-get update && \
    apt-get install -y git jq python3 bc dos2unix && \
    cargo install tokei

WORKDIR /app
COPY files /app/
RUN chmod +x analyze.sh && \
    dos2unix analyze.sh 