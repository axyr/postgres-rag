# Build stage
ARG IMAGE_PLATFORM=linux/amd64

FROM --platform=$IMAGE_PLATFORM paradedb/paradedb:latest-pg17 AS build

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    curl \
    build-essential \
    git \
    postgresql-server-dev-17 \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/pgvector/pgvector.git /tmp/pgvector && \
    cd /tmp/pgvector && \
    make && \
    make install && \
    rm -rf /tmp/pgvector

FROM --platform=$IMAGE_PLATFORM paradedb/paradedb:latest-pg17

COPY --from=build /usr/lib/postgresql/17/lib/vector.so /usr/lib/postgresql/17/lib/postgresql/

EXPOSE 5432

CMD ["postgres"]