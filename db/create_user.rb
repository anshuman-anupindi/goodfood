require 'bcrypt'
require_relative 'helpers.rb'


email = "dt@ga.co"
password = "pudding"

password_digest = BCrypt::Password.create(password)


sql = "INSERT INTO users (email, password_digest) VALUES ($1, $2)"

run_sql(sql, [email, password_digest])