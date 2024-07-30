FROM node:22.5.1-alpine3.19 AS base

WORKDIR /workspace
RUN npm install -g hexo-cli

FROM base AS build

COPY . /workspace

FROM nginx:1.21.3-alpine

COPY --from=build /workspace/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
