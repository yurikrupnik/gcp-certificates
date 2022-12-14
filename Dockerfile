
# Done!
FROM node:19-alpine AS node
WORKDIR /app
ARG DIST_PATH
# RUN test -n "$DIST_PATH" || (echo "DIST_PATH  not set" && false)
ENV NODE_ENV=$NODE_ENV
COPY ./$DIST_PATH .
RUN npm install
ENV PORT=8080
EXPOSE ${PORT}
CMD ["node", "main.js"]

# Done!
FROM node:19-alpine AS bun
WORKDIR /app
ARG DIST_PATH
# RUN test -n "$DIST_PATH" || (echo "DIST_PATH  not set" && false)
ENV NODE_ENV=$NODE_ENV
COPY ./$DIST_PATH .
RUN npm install
ENV PORT=8080
EXPOSE ${PORT}
CMD ["bun", "main.js"]

# Done
FROM nginx:alpine AS nginx
#FROM haproxy:alpine AS web-builder
WORKDIR /app
ARG DIST_PATH
RUN test -n "$DIST_PATH" || (echo "DIST_PATH  not set" && false)
COPY ./$DIST_PATH /usr/share/nginx/html
#COPY ./apps/users/client/k8s/base/haproxy.cfg /etc/haproxy/haproxy.cfg
ENV PORT=80
EXPOSE ${PORT}
CMD ["nginx", "-g", "daemon off;"]
#CMD ["haproxy", "start"]

# Done
FROM scratch AS scratch
WORKDIR /
ARG DIST_PATH
#RUN test -n "$DIST_PATH" || (echo "DIST_PATH  not set" && false)
ARG ENTRY_NAME=app
ENV PORT=8080
EXPOSE ${PORT}
COPY $DIST_PATH ./app
EXPOSE ${PORT}
ENTRYPOINT ["/app"]

FROM alpine AS alpine
WORKDIR /
ARG DIST_PATH
#RUN test -n "$DIST_PATH" || (echo "DIST_PATH  not set" && false)
ARG ENTRY_NAME=app
ENV PORT=8080
EXPOSE ${PORT}
COPY $DIST_PATH ./app
EXPOSE ${PORT}
ENTRYPOINT ["/app"]

# fails on m1
FROM jarredsumner/bun:edge AS root
#WORKDIR /
COPY package.json .
COPY bun.lockb .
RUN bun i
#COPY . .

