FROM node:18

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN find /usr/src/app -type d -exec chmod 0755 {} \;
RUN find /usr/src/app -type f -exec chmod 0644 {} \;

EXPOSE 8080

RUN groupadd -g 2000 octopus && useradd -m -u 2001 -g octopus octopus
USER 2001

CMD [ "node", "src/server.js" ]
