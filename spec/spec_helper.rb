ENV["RACK_ENV"] = "test"
require("rspec")
require("pg")
require("sinatra/activerecord")
require("recipe")
require "pry"
require "shoulda-matchers"


RSpec.configure do |config|
  config.after(:each) do
    Recipe.all.each do |d|
      d.destroy
    end
  end
end
