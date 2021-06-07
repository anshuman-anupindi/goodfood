require 'pg'

def run_sql (sql, params = [])
    db = PG.connect(PG.connect(ENV['DATABASE_URL'] || {dbname: 'goodfoodhunting'}))
    # res = db.exec(sql)
    res = db.exec_params(sql, params)
    db.close
    return res
end