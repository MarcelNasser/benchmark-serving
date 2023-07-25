const redis = require('redis');

const http = require('http');

const port = 8000;

const redis_connexion="redis://"+process.env.USERNAME+":"+process.env.PASSWORD+"@redis:6379/"+process.env.DB
console.log('redis_connexion=',redis_connexion);
const client = redis.createClient(
      {url: redis_connexion}
      );
client.on('error', err => console.log('Redis Client Error', err));
client.connect();

const server = http.createServer();
server.on('request', async (req, res) => {
  const value = await client.get('Hello');
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('NodeJs Server: Hello, '+value+'!');
});

server.listen(port, async () =>  {
  console.log(`Server running at http://localhost:${port}/`)
  await client.set('Hello', 'world');
});
