import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options
define("port", default=1234, help="run on the given port", type=int)

class IndexHandler(tornado.web.RequestHandler):
    def post(self):
        data = self.request.body
        print data
        data_dic = eval(data)
        data_get = data_dic['keys']
        self.write(data_get + 'get')

if __name__ == "__main__":
    tornado.options.parse_command_line()
    app = tornado.web.Application(handlers=[(r"/shake", IndexHandler)])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()