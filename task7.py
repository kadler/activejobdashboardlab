#!/usr/bin/env python3 
from bottle import route, run, request, static_file, template
import ibm_db_dbi as dbi
from string import capwords
import config



@route('/', method=('GET', 'POST'))
def root():
    sorting = request.forms.get('sorting') or '""'
    reset_parm = 'YES' if request.forms.get('reset') == 'true' else 'NO'
    show_columns = (
        'JOB_NAME', 'AUTHORIZATION_NAME', 'JOB_TYPE', 'FUNCTION_TYPE',
        'FUNCTION', 'JOB_STATUS', 'ELAPSED_INTERACTION_COUNT',
        'ELAPSED_TOTAL_RESPONSE_TIME', 'ELAPSED_TOTAL_DISK_IO_COUNT',
        'ELAPSED_ASYNC_DISK_IO_COUNT', 'ELAPSED_SYNC_DISK_IO_COUNT',
        'ELAPSED_CPU_PERCENTAGE', 'ELAPSED_CPU_TIME',
        'ELAPSED_PAGE_FAULT_COUNT' )
    hide_columns = ( 'ELAPSED_TIME', )
    all_columns = show_columns + hide_columns
    columns_string = ",".join(all_columns)
    
    
    query = "select %s from table(qsys2.active_job_info(RESET_STATISTICS => ?)) x where job_type <> 'SBS'" % columns_string
    
    conn = dbi.pconnect(dsn=None, database='*LOCAL', user=None, password=None)
    cur = conn.cursor()
    cur.execute(query, (reset_parm, ))
    
    elapsed_time = 0
    
    row_data = []
    for row in cur:
        row_data.append(row[0 : len(show_columns)])
        elapsed_time = row[-1]
    
    headers = [capwords(column.replace('_', ' ')) for column in show_columns]
    return template('task7', rows=row_data, headers=headers, elapsed_time=elapsed_time, sorting=sorting)

run(**config.options)
