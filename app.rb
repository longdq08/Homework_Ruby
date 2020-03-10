require 'rubygems'
require 'sinatra'
require 'active_record'
require 'fileutils'
require "down"

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "123456",
  :database => "Test"
)

class User < ActiveRecord::Base
end

# ActiveRecord::Migration.create_table :users do |t|
#   t.string :name
#   t.integer: age
# end

class App < Sinatra::Application
end

# display all users (OK)
get '/users' do
  @users = User.all
  erb :index
end

# show a user (OK)
get '/users/:id' do
  @user = User.find(params[:id])
  erb :show
end

# show form to create new user (OK)
get '/new' do
    erb :new
end

# save user and redirect '/users' (OK)
post '/users' do
  user = User.new
  user.name = params[:fname]
  user.age = params[:fage]
  user.save
  redirect '/users'
end

# display edit form to update user (OK)
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :edit
end

# update user (OK)
put '/users/:id' do
  user = User.find(params[:id])
  user.name = params[:newName]
  user.age = params[:newAge]
  user.save
  redirect '/users'
end

# delete user (OK)
delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy
  redirect '/users'
end

# show all pictures (OK)
get '/pictures' do
  @dir = "public/uploads"
  Dir.foreach("public/uploads") do |picture|
    if File.file?("public/uploads/#{picture}")
      puts picture
    end
  end
  erb :pictures
end

# show upload form (OK)
get '/upload' do
  erb :upload
end

post '/upload' do
  tempfile = params[:file][:tempfile] 
  filename = params[:file][:filename] 
  FileUtils.cp(tempfile.path, "public/uploads/#{filename}")
  redirect '/pictures'
end

# download image (OK)
get '/download/:filename' do |filename|
  tempfile = Down.download("http://localhost:4567/uploads/#{filename}", destination: "public/download")
  redirect '/pictures'
end

# delete image (OK)
get '/remove/:filename' do |filename|
  File.delete("public/uploads/#{filename}")
  redirect '/pictures'
end

not_found do
  status 404
  'not found'
end