FROM alpine:3.7
RUN mkdir /app
WORKDIR /app

COPY ./ /app/
RUN ls -la /app