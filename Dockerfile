FROM alpine:3.7
RUN mkdir /app

RUN mkdir /volume
VOLUME /volume

EXPOSE 8000

WORKDIR /app

COPY ./ /app/
RUN ls -la /app