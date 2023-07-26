import http.server
import socketserver
from http import HTTPStatus
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


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(HTTPStatus.OK)
        self.end_headers()
        # read DB
        try:
            self.wfile.write(f"Python Server: Hello, {r.get('Hello')}!".encode())
        except Exception as e:
            logger.error(e)
            self.wfile.write(f"Python Server: Error: {e}!".encode())


httpd = socketserver.TCPServer(('', 8000), Handler)
httpd.serve_forever()
