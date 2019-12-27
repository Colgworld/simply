FROM mhart/alpine-node:8

WORKDIR /

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

RUN npm run css

CMD [ "node", "server.js" ]