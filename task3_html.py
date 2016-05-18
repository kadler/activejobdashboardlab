#!/usr/bin/env python3 
from bottle import route, run, response, template
from itoolkit import *
from itoolkit.lib.ilibcall import *

import config

@route('/')
def root():
    itool = iToolKit()
    itransport = iLibCall()
    
    itool.add(iCmd5250('wrkactjob', 'WRKACTJOB'))
    itool.call(itransport)
    wrkactjob_dict = itool.dict_out('wrkactjob')
    data = wrkactjob_dict['wrkactjob']
    return template('task3', data=data)

run(**config.options)