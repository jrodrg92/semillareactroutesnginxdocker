FROM ubuntu:18.04

LABEL version = 1.0.0
LABEL description = "This is a aplication imagen"
LABEL vendor = yo

# Update the repository sources list
RUN apt-get update

# Install and run apache
RUN apt-get install curl -y
RUN apt-get install vim -y
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install nodejs -y
RUN apt-get install git -y
RUN apt-get install build-essential -y
RUN apt-get install nginx -y
ARG DEBIAN_FRONTEND=noninteractive

FROM node:13.12.0-alpine as build
# set working directory
WORKDIR /semillareactroutesnginxdocker

# add `/app/node_modules/.bin` to $PATH
ENV PATH /semillareactroutesnginxdocker/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY package-lock.json ./

RUN npm ci --silent
RUN npm install react-scripts@3.4.1 -g --silent
COPY . ./
RUN npm run build

FROM nginx:stable-alpine

RUN rm /usr/share/nginx/html/index.html
COPY --from=build /semillareactroutesnginxdocker/build /usr/share/nginx/html

# new
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

RUN ls /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

