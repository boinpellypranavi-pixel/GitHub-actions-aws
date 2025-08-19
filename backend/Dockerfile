1  FROM node:18
2  WORKDIR /usr/src/app
3  COPY package*.json ./
4  RUN npm install
5  COPY . .
6  EXPOSE 5000
7  CMD ["node", "index.js"]
