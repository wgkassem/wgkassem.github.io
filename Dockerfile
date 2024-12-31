FROM node:22.5.1-alpine3.19 AS base

RUN apk add --no-cache git
WORKDIR /workspace
COPY package.json package-lock.json /workspace/
RUN npm ci

FROM base AS build

COPY . /workspace
RUN npm run build

FROM nginx:1.21.3-alpine

COPY --from=build /workspace/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
