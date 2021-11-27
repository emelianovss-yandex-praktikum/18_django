# Docker

- [ ] Что такое докер - namespaces, пример с proc/{pid}/stats
- [ ] Сборка образа и кэширование слоев
- [ ] Контейнер: запуск, поговорим про CMD и ENTRYPOINT
- [ ] Главное при отладке: inspect, exec, bash
- [ ] Network: publish, host
- [ ] Volumes
- [ ] Env
- [ ] Полезности: stats, cp, history, ps, ps -a, --format
- [ ] docker-compose

## Docker tips & tricks
### Context
```bash
truncate -s 10M big_file.txt
```

```
docker build -t temp:latest -f context.Dockerfile .
```

```yaml
version: "3.5"

services:
  temp:
    build:
      context: .
      dockerfile: context.Dockerfile
```

* Сборка образа происходит быстрее
* В образ не попадает всякий хлам

### Volume
```yaml
version: "3.5"

services:
  vol_no_name:
    build:
      context: .
      dockerfile: context.Dockerfile

  vol_with_name:
    build:
      context: .
      dockerfile: context.Dockerfile

  vol_file:
    build:
      context: .
      dockerfile: context.Dockerfile

```


### Networks

```
docker run --rm -p 8001:8000 python:3.7-alpine python -m http.server
```

```
docker run --rm -p 127.0.0.1:8002:8000 python:3.7-alpine python -m http.server
```

```
docker run --rm --network=host python:3.7-alpine python -m http.server
```

```yaml
version: "3.5"

services:
  container_with_publish:
    image: python:3.7-alpine
    ports:
      - 8001:8000
    command: ['python', '-m', 'http.server']

  container_with_publish_local:
    image: python:3.7-alpine
    ports:
      - 127.0.0.1:8002:8000
    command: ['python', '-m', 'http.server']

  container_host_net:
    image: python:3.7-alpine
    network_mode: host
    command: ['python', '-m', 'http.server']
```

```
docker container_name_1 container_name_2 --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"
```

```
ssh -L local_port:remote_interface:remote_port user@host
```

### Multistage build
```yaml
version: "3.5"

services:
  backendapi:
    image: python:3.7-alpine
    network_mode: host
    volumes:
      - ./server.py:/server.py:ro
    command: ['python', '/server.py']

  front_prod:
    build:
      context: .
      dockerfile: multistage.Dockerfile
    network_mode: host
    volumes:
      - default.prod.conf:/etc/nginx/conf.d/default.conf:ro

  front_dev:
    image: nginx
    network_mode: host
    volumes:
      - default.dev.conf:/etc/nginx/conf.d/default.confd:ro

```

### Environment
docker-compose version

### Labels
Example with image

## Links
- [cgroups and namespaces](https://www.nginx.com/blog/what-are-namespaces-cgroups-how-do-they-work/)
- [cgroups and namespaces, классное видео](https://www.youtube.com/watch?v=rJRLZfk3a8U)
- [entrypoint and cmd](https://habr.com/ru/company/southbridge/blog/329138/)
- [network](https://linux-notes.org/rabota-s-setju-networking-v-docker/)
- [volumes](https://slurm.io/tpost/i5ikrm9fj1-hranenie-dannih-v-docker)
- [список советов](https://ealebed.github.io/tags/docker/)