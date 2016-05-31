import tornado.web
import Utils
import logging


class GetMovieList(tornado.web.RequestHandler):

    def get(self):
        #print self.request
        print self.request.body
        movie_list = Utils.get_movie_list()
        response_value = dict()
        response_value['movie_list'] = movie_list
        logging.info('Get movie list Response movie list length = %d' % (len(movie_list),))
        self.write(Utils.to_json_value(response_value))
        pass

    def post(self):
        print self.request.body
        movie_list = Utils.get_movie_list()
        response_value = dict()
        response_value['movie_list'] = movie_list
        logging.info('Get movie list Response movie list length = %d' % (len(movie_list),))
        self.write(Utils.to_json_value(response_value))
        pass

