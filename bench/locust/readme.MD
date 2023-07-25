## benchmark with lotus

lotus is already deployed with docker compose stack.

connect to locust => [localhost:8089](http://localhost:8089).

define a load protocol.

example:

````text
0. set 100 concurrent connexion
1. set stepping of 10 
2. define the host: http://python:8000 or http://fastapi:8000 or http://go:8000 or http://nodejs:8000
3. quick the bench
4. one minute later increases user connexions to 200
5. then 500
6. after 10 minutes, stop the bench
````

for each load bench save the [stats/report](http://localhost:8089/stats/report) 

- go => [report](./reports/report_go.html)
- fast => [report](./reports/report_fastapi.html)
- python => [report](./reports/report_python.html)
 

comments:

- go is faster by an order of magnitude.
- go performance degrades less with number of connexions. 
- python is way slower.
- python performance dramatically collapse with higher loads. The response times get off the roof!
- fastapi contains the response time degradation. But it is not that fast...