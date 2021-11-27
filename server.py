import random
import json
from http.server import BaseHTTPRequestHandler, HTTPServer


class IndexHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps({'random_int': random.randint(1, 1000)}).encode())
        return


def run():
    server_address = ('', 8000)
    httpd = HTTPServer(server_address, IndexHandler)
    httpd.serve_forever()


if __name__ == '__main__':
    run()