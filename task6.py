#!/usr/bin/env python3 
from bottle import route, run, request, template
import ibm_db_dbi as dbi

import config

@route('/', method=('GET', 'POST'))
def root():
    reset_parm = 'YES' if request.forms.get('reset') == 'true' else 'NO'
    
    
    
    
    
    
    query = "select subsystem, job_name, function_type, function, job_type, elapsed_time from table(qsys2.active_job_info(RESET_STATISTICS => ?)) x where job_type <> 'SBS'"
    
    conn = dbi.pconnect(dsn=None, database='*LOCAL', user=None, password=None)
    cur = conn.cursor()
    cur.execute(query, (reset_parm, ))
    
    
    
    
    
    headers = [descr[0] for descr in cur.description]
    return template('task6', rows=cur, headers=headers)

run(**config.options)