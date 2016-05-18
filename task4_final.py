#!/usr/bin/env python3 
from bottle import route, run, template
import ibm_db_dbi as dbi

import config

@route('/')
def root():
    query = "select subsystem, job_name, function_type, function, job_type, elapsed_time from table(qsys2.active_job_info()) x where job_type <> 'SBS'"
    
    conn = dbi.pconnect(dsn=None, database='*LOCAL', user=None, password=None)
    cur = conn.cursor()
    cur.execute(query)
    
    headers = [descr[0] for descr in cur.description]

    return template('task4_final', rows=cur, headers=headers)

run(**config.options)