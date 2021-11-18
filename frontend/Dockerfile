FROM node:14.18

WORKDIR /frontend
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

CMD ["yarn", "start"]
