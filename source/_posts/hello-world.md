---
title: Hello World
date: 2024-10-16
---

Welcome to my website! This is my first post, and it's going to be about how I set up this website: how I got the dependencies and how I was able to publish to github pages.

Getting this website up and running required one night's worth of work. So, if you want to dot the same for your github page, here's how you can do it:

## Getting dependencies and development container

0. [hexo-icarus-theme](https://github.com/ppoffice/hexo-theme-icarus) is the main dependency of this site. To avoid accidentally breaking your website should the theme be updated *AND* for future customization-ility, we are going to fork the theme repo on Github and pull it locally.
```
# dont forget to fork on GH first
gh repo clone <your-gh-username>/hexo-icarus-theme
```

1. Let's create a new repo to hold the website source tree. This will be the repo that you will push to Github Pages.
```
mkdir $USER.github.io
cd $USER.github.io
git init
```
You might want to change `$USER` to your Github user or organization name.

2. Next is a Dockerfile that will build your site locally in a "controlled environment": no polluting your machine with node stuff, development isolation, etc
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

3. Add a .devcontainer for development purposes (things might break and you might want to debug why)

```yaml
# .devcontainer/compose.yml
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    image: my-website-server
    ports:
      - "80:80"
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

Make sure to follow [icarus docs](https://ppoffice.github.io/hexo-theme-icarus/). For more information.

## Deploying to Github Pages

The easiest way to deploy to Github pages is to follow the example from [deploy-pages action](https://github.com/actions/deploy-pages).
Checkout my [workflow](https://github.com/wgkassem/wgkassem.github.io/blob/main/.github/workflows/pages.yml) for this website.

