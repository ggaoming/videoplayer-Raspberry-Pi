# -*- coding:utf8 -*-
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from tornado.options import define, options
import os
from GetMovieList import GetMovieList

define("port", default=1234, help="run on the given port", type=int)


if __name__ == "__main__":

    tornado.options.parse_command_line()
    app = tornado.web.Application(
        handlers=[
            (r"/get_movie_list", GetMovieList),
        ],
        template_path=os.path.join(os.path.dirname(__file__), "templates"),
        static_path=os.path.join(os.path.dirname(__file__), "static"),

    )
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()
    pass
