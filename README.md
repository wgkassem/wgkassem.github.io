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

You shouldn't need to, but just in case you need to debug why the backend/page is not working as expected:


```bash
docker compose -f .devcontainer/compose.yml up -d --build
docker compose -f ./devcontainer/compose.yml exec sh
```
