# ===================================> Build image
FROM node:14-alpine
COPY . /bootcamp-app
WORKDIR /bootcamp-app
ARG port=8080
ENV port=$port
EXPOSE $port

# ========================> Install dependencies
RUN npm install

# ========================> Run app
CMD npm run dev
