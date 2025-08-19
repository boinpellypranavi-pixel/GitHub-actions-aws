1  # Stage 1: Build React app
2  FROM node:18 AS build
3  WORKDIR /usr/src/app
4  COPY package*.json ./
5  RUN npm install
6  COPY . .
7  RUN npm run build
8
9  # Stage 2: Serve with Nginx
10 FROM nginx:alpine
11 COPY --from=build /usr/src/app/build /usr/share/nginx/html
12 EXPOSE 3000
13 CMD ["nginx", "-g", "daemon off;"]
