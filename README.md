# Description

Personal website, blog, and logbook.
Sharing my thoughts, ideas, and projects.

# Dependencies

- Docker

# Building and running

```bash
docker compose up -d --build
# go to http://localhost
``````

# Development

```bash
docker compose -f .devcontainer/compose.yml up -d --build
docker compose -f ./devcontainer/compose.yml exec sh
```
