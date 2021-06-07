require 'pg'
require 'pry'

db = PG.connect(dbname: 'goodfoodhunting')

res = db.exec("SELECT * FROM dishes;")

# binding.pry


res.to_a.each do |dish|
    puts dish["name"]
end


db.close