FROM node:15
WORKDIR /app
COPY package.json .
RUN npm install --lagacy-peer-deps
COPY . ./ 
ENV REACT_APP_MOVIE_DB=9367e2a6
CMD ["npm","start"]