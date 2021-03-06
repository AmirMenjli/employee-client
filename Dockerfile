FROM node:12.16.1-alpine As builder

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:1.15.8-alpine

COPY ./docker/nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /usr/src/app/dist/employee-client/ /usr/share/nginx/html
