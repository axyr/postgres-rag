
```bash
 docker build . --tag ghcr.io/axyr/laravel-base-image:latest --platform linux/amd64,linux/arm64

```

```bash
 docker run -e POSTGRES_PASSWORD=password -p 5432:5432  -d --name pg_rag pg_rag
```