#!/usr/bin/env python3 
from bottle import route, run

import config

@route('/')
def root():
    return "Hello, world!"
#     raise Exception


run(**config.options)