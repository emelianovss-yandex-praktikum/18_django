FROM node:8.16.1-jessie
RUN mkdir /temp
WORKDIR /temp
COPY ./frontend/package.json /temp/package.json
COPY ./frontend/yarn.lock /temp/yarn.lock
RUN yarn
COPY ./frontend/ /temp/
RUN yarn build

FROM nginx:1.17.3-alpine
RUN mkdir /www /www/frontend
COPY --from=0 /temp/build/ /www/frontend/
