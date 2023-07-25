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
The most critical parameter of the benchmark is here
````yaml
#0: Test 'Python' Server (8000) with 200 runners, time = 5.212
#1: Test 'Fastapi' Server (8001) with 200 runners, time = 5.303
#2: Test 'Go' Server (8002) with 200 runners, time = 5.276
#3: Test 'NodeJs' Server (8003) with 200 runners, time = 5.234
````



- method #1: manual 

````bash
## send 6000 requests to each server
$ bash bench/manual/run.sh
````
````output
#0: Test 'Python' Server (8000) with 200 runners, time = 5.212
#1: Test 'Fastapi' Server (8001) with 200 runners, time = 5.303
#2: Test 'Go' Server (8002) with 200 runners, time = 5.276
#3: Test 'NodeJs' Server (8003) with 200 runners, time = 5.234
````

````bash
## control # of runners and requests per runner
$ RUNNERS=100 REQUESTS=100 bash bench/manual/run.sh
````

- method #2: locust 