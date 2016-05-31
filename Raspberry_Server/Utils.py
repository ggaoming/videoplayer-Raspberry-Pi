import os
import json


def get_movie_list():
        file_names = os.listdir("static")
        movie_names = []
        name_list = ['avi', 'rmvb', 'rm', 'asf', 'divx', 'mpg', 'mpeg', 'mpe', 'wmv', 'mp4', 'mkv', 'vob']
        for fn in file_names:
            temp = fn.split('.')
            if len(temp) == 2 and temp[1] in name_list:
                movie_names.append(fn)
        return movie_names
        pass


def to_json_value(data):
    return json.dumps(data)
    pass
