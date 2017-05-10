require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/recipe")
require("pg")

get "/" do
  erb :index
end
