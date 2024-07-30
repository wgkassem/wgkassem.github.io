FROM node:22.5.1-alpine3.19 AS base

WORKDIR /workspace
RUN npm install -g hexo-cli

FROM base AS build

COPY . /workspace
RUN hexo generate

FROM nginx:1.21.3-alpine

COPY --from=build /workspace/public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
