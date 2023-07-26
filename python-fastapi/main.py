import uvicorn as uvicorn
from fastapi import FastAPI
import redis
import os
from logging import getLogger, basicConfig, ERROR

logger = getLogger("python-server")
basicConfig(level=ERROR, format="%(levelname)s: %(message)s")

r = redis.Redis(host='redis', port=6379,
                db= int(os.environ.get("DB", 0)),
                decode_responses=True)

logger.info(f"redis username={os.environ.get('USERNAME', '')}")

try:
    r.set('Hello', 'world')
except redis.exceptions.AuthenticationError:
    logger.error("bad username/password")
except Exception as e:
    logger.error(e)


app = FastAPI()

@app.get("/")
async def root():
    return f"Python FastAPI: Hello, {r.get('Hello')}!".encode()



if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)

