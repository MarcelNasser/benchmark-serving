import http.server
import socketserver
from http import HTTPStatus
import redis
import os


r = redis.Redis(host='redis', port=6379,
                username=os.environ.get("USER", ""),
                password=os.environ.get("PASSWORD", ""),
                db= os.environ.get("DB", ""),
                decode_responses=True)


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(HTTPStatus.OK)
        self.end_headers()
        self.wfile.write(b'Hello, world!')


httpd = socketserver.TCPServer(('', 8000), Handler)
httpd.serve_forever()
