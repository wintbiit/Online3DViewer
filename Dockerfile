FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build_website_dev

FROM nginx:1.27-alpine
COPY --from=build /app/website /usr/share/nginx/html/website
COPY --from=build /app/build /usr/share/nginx/html/build
COPY --from=build /app/cloudreve.html /usr/share/nginx/html/cloudreve.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
