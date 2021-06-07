require 'sinatra'
require 'sinatra/reloader' if development?
# only reloads THIS file. changing any other .rb file will require server restart.
require 'pry'
require 'bcrypt'

require_relative 'db/helpers.rb'

enable :sessions

def current_user
  if session[:user_id] == nil
    return {}
  end
  run_sql("SELECT * FROM users WHERE id = #{session[:user_id]};")[0]
end

def logged_in?
  if session[:user_id] == nil
    return false
  else
    return true
  end
end

get '/' do
  dishes = run_sql("SELECT * FROM dishes;")
  erb :index, locals: {dishes: dishes}
end

get '/dishes/new' do
  erb :new_dish_form
end

get '/dishes/:id' do
  res = run_sql("SELECT * FROM dishes WHERE id = $1;", [params["id"]])
  dish = res[0]

  erb :show_dish, locals: {dish: dish}
end

post '/dishes' do
  redirect '/login' unless logged_in?

  sql = "INSERT INTO dishes (name, image_url, user_id) VALUES ($1, $2, $3);"
  run_sql(sql, [params['name'], params['image_url'], current_user()['id']])
  redirect '/'
end

delete '/dishes/:id' do

  redirect '/login' unless logged_in?
  id = params['id']
  sql = "DELETE FROM dishes WHERE id = #{id}"
  run_sql(sql)

  redirect '/'

end

get '/dishes/:id/edit' do
  res = run_sql("SELECT * FROM dishes WHERE id = #{params['id']};")
  dish = res[0]
  erb :edit_dish_form, locals: {dish: dish}
end

put '/dishes/:id' do
  sql = "UPDATE dishes SET name = $1, image_url = $2 WHERE id = $3;"

  run_sql(sql, [params['name'], params['image_url'], params['id']])

  redirect "/dishes/#{params['id']}"
end

get '/login' do
  erb :login
end

post '/session' do
  records = run_sql("SELECT * FROM users WHERE email = '#{params["email"]}';")

  if records.count > 0 && BCrypt::Password.new(records[0]['password_digest']) == params['password']
    logged_in_user = records[0]
    session[:user_id] = logged_in_user["id"]
    redirect '/'

  else
    erb :login
  end
end

delete '/session' do

  session[:user_id] = nil
  redirect '/login'
end

# httparty - makes http request

# pg - talks to your postgres data

# single request response cycle


















