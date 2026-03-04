#!/usr/bin/env python3
import http.server
import socketserver
import os
import sys

PORT = 8080

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        try:
            if self.path == '/' or self.path == '/cart-jsp/':
                jsp_file = os.path.join(os.getcwd(), 'src/main/webapp/cart.jsp')
                with open(jsp_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                self.send_response(200)
                self.send_header('Content-type', 'text/html; charset=utf-8')
                self.send_header('Content-Length', len(content.encode('utf-8')))
                self.end_headers()
                self.wfile.write(content.encode('utf-8'))
            elif self.path == '/index.jsp':
                self.send_response(301)
                self.send_header('Location', '/cart-jsp/')
                self.end_headers()
            else:
                super().do_GET()
        except Exception as e:
            print(f"Error: {e}", file=sys.stderr)
            self.send_error(500, str(e))

try:
    os.chdir('e:\\SD\\lab 3')
    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        print(f"Server running at http://localhost:{PORT}/cart-jsp/", flush=True)
        sys.stdout.flush()
        httpd.serve_forever()
except Exception as e:
    print(f"Failed to start server: {e}", file=sys.stderr)
    sys.exit(1)
