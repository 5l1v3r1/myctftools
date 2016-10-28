#!/usr/bin/env python
#*-* coding:utf-8 -*-

from SocketServer import ThreadingTCPServer, StreamRequestHandler 
from datetime import datetime


class MyTCPHandler(StreamRequestHandler): 

    def handle(self):
        self.data = self.rfile.readline().strip()
        msg = "%s -> %s:%s"%(datetime.now().strftime('%H:%M:%S'),self.client_address[0],self.data)
        print msg
        #self.wfile.write('')     

if __name__ == "__main__":
    HOST, PORT = "0.0.0.0", 6061
    server = ThreadingTCPServer((HOST, PORT), MyTCPHandler)
    server.serve_forever() 