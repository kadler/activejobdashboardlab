#!/usr/bin/env python3 
from bottle import route, run
from itoolkit import *
from itoolkit.lib.ilibcall import *

import config

@route('/')
def root():
    itool = iToolKit()
    itransport = iLibCall()
    
    itool.add(iCmd5250('wrkactjob', 'WRKACTJOB'))
    itool.call(itransport)
    
    return "WRKACTJOB output here"

run(**config.options)