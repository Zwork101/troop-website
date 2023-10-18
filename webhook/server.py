from http.server import BaseHTTPRequestHandler, HTTPServer
from subprocess import STDOUT, Popen
from pathlib import Path
from datetime import datetime

base_path = Path(__file__).parent.parent

def build_site():
    with open(base_path.joinpath(f"builds/{datetime.now().strftime('%Y%m%d-%H%M%S')}.log"), "w") as out:
        try:
            jekyll = Popen(["bundle", "exec", "jekyll", "build", "--trace"], stdout=out, stderr=STDOUT, cwd=base_path, shell=True)
            jekyll.wait(180)
        except TimeoutError:
            return False, 412, out.name

        if jekyll.returncode != 0:
            return False, 503, out.name
        return True, 201, out.name

class BuildWebhook(BaseHTTPRequestHandler):
    def do_POST(self):
        print("Got request to build.")
        success, code, fname = build_site()
        if success:
            self.send_response(code)
            print("Build completed.")
        else:
            self.send_error(code)
            print(f"Build failed. {code}")

        self.end_headers()
        self.wfile.write(fname.encode())

if __name__ == "__main__":
    server = HTTPServer(("localhost", 9090), BuildWebhook)
    print("Server starting...")
    print(base_path)

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.server_close()

    print("Server stopped.")
