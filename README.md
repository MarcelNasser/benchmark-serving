# benchmark-serving

investigation of legendary performance gap between languages.

benchmark of hello-world servers with different language (go, python, nodejs...).

tests carried with docker.

run all servers.

````bash
$ docker compose up -d
````
---
connect to:

- locust => [localhost:8089](http://localhost:8089)
- monitoring => [localhost:3000](http://localhost:3000/containers/docker)

---
check `hello-world` responses:

- python `hello-world` => [localhost:8000](http://localhost:8000)
- fastapi `hello-world` => [localhost:8001](http://localhost:8001)
- go `hello-world` => [localhost:8002](http://localhost:8002)
- nodejs `hello-world` => [localhost:8003](http://localhost:8003)

---
benchmark(s):

- setup:

The most critical parameter of the benchmark is in the [docker-compose-server.yml](./docker-compose-server.yml)
````yaml
services:

  .server:
    container_name: server
    image: busybox
    deploy:
      resources:
        limits:
          ## The most critical parameter of the benchmark
          ## is this Guy =>>
          cpus: 0.04
          ## set a reasonable value according to the hardware
          ## for a 12 cores CPU a value between 0.04 and 0.33
          ## human translation: the bench will use between 0.5 and 4 cores
          memory: "150MB"
````

Then, update de deployment:
````bash
$ docker compose up -d
````


- method #1: manual => [doc](./bench/locust/readme.MD)


- method #2: locust => [doc](./bench/locust/readme.MD)
