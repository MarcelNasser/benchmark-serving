# benchmark-serving

![example workflow](https://github.com/MarcelNasser/benchmark-serving/actions/workflows/docker.yml/badge.svg)


investigation of legendary performance gap between languages.

benchmark of hello-world server `go` vs `python` vs `nodejs` (...).

---
### result(s)



---
### version(s)

language(s):

| language | version |
|----------|---------|
| go       | 1.20    |
| nodejs   | 18      |
| python   | 3.10    |

OS:

| os     | version |
|--------|---------|
| alpine | 3.18    |

package(s):

| package       | version |
|---------------|---------|
| redis(python) | 4.6.0   |
| redis(go)     | v9.0.5  |
| redis(nodejs) | 4.6.7   |
| fastapi       | 0.100.0 |
| uvicorn       | 0.23.0  |

---

tests carried with [docker](https://docs.docker.com/engine/install/).

---
deploy all servers =>>

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


- benchmark #1: `bash` => [doc](./bench/manual/readme.MD)


- benchmark #2: `locust` => [doc](./bench/locust/readme.MD)


- setup:

The most critical parameter of the benchmark is the amount of CPU given to each server.

update value here > [docker-compose-server.yml](./docker-compose-server.tmpl.yml)

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
          ## hope you won't miss it :)
          memory: "150MB"
````

Then, update de deployment:
````bash
$ docker compose up -d
````


