---
title: Hello World
---

Welcome to my website! This is my first post.

Getting this website up and running required one night's worth of work.

0. Fork the [hexo-icarus-theme](https://github.com/ppoffice/hexo-theme-icarus) repository so we can keep things consistent
```
gh repo clone <your-gh-username>/hexo-icarus-theme
```

1. Create a new repository to hold your website sources
```
mkdir logbook
cd logbook
git init
```

2. Next is a Dockerfile.
```Dockerfile
# Dockerfile

## Base and dependencies
FROM node:22.5.1-alpine3.19 AS base
WORKDIR /workspace
RUN npm install -g hexo-cli

## Copy sources for build
FROM base AS build
COPY . /workspace
RUN hexo generate

## Deploy
FROM nginx:1.21.3-alpine
COPY --from=build /workspace/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

3. Dont forget a .devcontainer for development purposes

```yaml
# .devcontainer/compose.yml
services:
  dev:
    build:
      context: ..
      dockerfile: ./Dockerfile
      target: base

    image: my-website-server
    ports:
      - "80:4000"
    volumes:
      - type: bind
        source: ..
        target: /workspace

    command: ["tail", "-f", "/dev/null"]
```

4. You can now init the site, add icarus theme as a submodule, and start the server

```bash
docker compose -f ./devcontainer/compose.yml up -d --build
docker compose -f ./devcontainer/compose.yml exec hexo init .
git submodule add https://github.com/<your-gh-username>/hexo-icarus-theme themes/icarus
# you might need to run `npm install <some-packages>` to get things working
# dont forget to set icarus as the theme in _config.yml
docker compose -f ./devcontainer/compose.yml exec hexo server
```

5. Get the [experimental dark theme](https://github.com/ppoffice/hexo-theme-icarus/issues/564) and apply it

```bash
cd themes/icarus
git checkout night4
git remote add imaegoo https://github.com/imaegoo/hexo-theme-icarus.git
git fetch imaegoo
git merge imaegoo/night4
```

6. add .gitignore for things like `node_modules` etc

7. fix the `_config.yml` and `_config.icarus.yml` to your liking.

Make sure to follow [icarus docs](https://ppoffice.github.io/hexo-theme-icarus/).
