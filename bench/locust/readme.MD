## benchmark with lotus

lotus is already deployed with docker compose stack.

````bash
$ docker compose up -d
````
connect to locust => [localhost:8089](http://localhost:8089).

set the server.

| server(s) | url(s)              |
|-----------|---------------------|
| fastapi   | http://fastapi:8000 |
| go        | http://go:8000      |
| nodejs    | http://nodejs:8000  |
| python    | http://python:8000  |

---
define a load protocol. example:

````text
0. set 100 concurrent connexions
1. set stepping of 10 
2. define the host: http://python:8000 or http://fastapi:8000 or http://go:8000 or http://nodejs:8000
3. quick the bench
4. one minute later increases user connexions to 200
5. then 500
6. after 10 minutes, stop the bench
````
---
for each load bench save the [stats/report](http://localhost:8089/stats/report) 

- `go` => [report](./reports/report_go.html)
- `fastapi` => [report](./reports/report_fastapi.html)
- `python` => [report](./reports/report_python.html)


---

resources monitoring => [localhost:3000](http://localhost:3000/containers/docker)

---

comments from our own bench campaign (all server are given 0.5 CPUs):

- `go` is faster by an order of magnitude.
- `go` performance degrades less with number of connexions. 
- `python` is way slower.
- `python` performance dramatically collapse with higher loads. The response times skyrocket!
- `fastapi` response time is better than python native Server library. But Fastapi is not that fast...
