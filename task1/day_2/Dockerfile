FROM node:26-alpine

WORKDIR /app

COPY package*.json

RUM npm install

COPY . .

CMD ["node", "app.js"]

