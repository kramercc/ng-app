
# Stage 0, the build-stage, based on Node.js, to build/compile Angular

FROM node:10.9 as build-stage

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY ./ /app/

ARG configuration=production

RUN npm run build -- --output-path=./dist/out --configuration $configuration

# Stage 1 - based on Nginx, to have only the compile app installed, ready for production with Nginx

FROM nginx:1.15 

COPY --from=build-stage /app/dist/out/ /usr/share/nginx/html

COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

