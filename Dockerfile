FROM node:19.5.0-alpine as builder

WORKDIR /usr/app

COPY ./package.json ./
RUN npm install
COPY ./ ./

RUN npm run build

FROM nginx 

RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder usr/app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]