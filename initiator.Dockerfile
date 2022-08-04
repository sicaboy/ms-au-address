FROM node:16
WORKDIR /usr/src/app
COPY ./package*.json ./
#ADD ../* ./
RUN npm install
CMD [ "npm", "run", "loader" ]
