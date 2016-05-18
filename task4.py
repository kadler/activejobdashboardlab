#!/usr/bin/env python3 
from bottle import route, run, template
import ibm_db_dbi as dbi

import config

@route('/')
def root():
    query = "select subsystem, job_name, function_type, function, elapsed_time from table(qsys2.active_job_info()) x"
    
    conn = dbi.pconnect(dsn=None, database='*LOCAL', user=None, password=None)
    cur = conn.cursor()
    cur.execute(query)
    
    return template('task4', rows=cur)

run(**config.options)