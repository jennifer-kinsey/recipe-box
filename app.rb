require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/recipe')
require('pg')
require 'pry'

get '/' do
  recipes = Recipe.all
  ingredients = Ingredient.all
  @ingredients = ingredients.order(item: :desc)
  @recipes = recipes.order(rating: :desc)
  erb :index
end

get '/add_recipe' do
  erb :add_recipe
end

post '/add_recipe' do
  title = params['title']
  instructions = params['instructions']
  rating = params['rating']
  @recipe = Recipe.create(title: title, instructions: instructions, rating: rating)
  item = params['item']
  @ingredient = Ingredient.create(item: item)
  @ingredient.recipes.push(@recipe)
  if @recipe.save && @ingredient.save
    redirect '/'
  else
    erb(:error)
  end
end

get '/recipes/:id' do
  @recipe = Recipe.find(params['id'].to_i)
  erb :recipe
end

post '/add_ingredients/:id' do
  recipe = Recipe.find(params['id'].to_i)
  item = params['item']
  @ingredient = Ingredient.create(item: item)
  @ingredient.recipes.push(recipe)
  if @ingredient.save
    redirect "/recipes/#{recipe.id}"
  else
    erb(:error)
  end
end

delete '/delete/recipe/:id' do
  recipe = Recipe.find(params['id'].to_i)
  recipe.delete
  redirect '/'
end

get '/update/recipe/:id' do
  @recipe = Recipe.find(params['id'].to_i)
  erb :edit_recipe
end

patch '/update_recipe/:id' do
  @recipe = Recipe.find(params['id'].to_i)
  title = params['title']
  instructions = params['instructions']
  rating = params['rating']
  @recipe.update(title: title, instructions: instructions, rating: rating)
  item = params['item']
  @recipe.ingredients.first.update(item: item)
  @recipe = Recipe.find(params['id'].to_i)
  if @recipe.update(title: title, instructions: instructions, rating: rating)
    erb :recipe
  else
    erb :error
  end
end

post '/add_tags/:id' do
  recipe1 = Recipe.find(params['id'].to_i)
  name = params['tag']
  @tag = Tag.create(name: name)
  recipe1.tags.push(@tag)
  if @tag.save
    redirect "/recipes/#{recipe1.id}"
  else
    erb :error
  end
end

get '/tags/:id' do
  @tag = Tag.find(params['id'].to_i)
  @recipes = Recipe.all
  erb :tag
end

delete '/delete/tag/:id' do
  tag = Tag.find(params['id'].to_i)
  tag.delete
  redirect '/'
end

patch '/edit/tag/:id' do
  @tag = Tag.find(params['id'].to_i)
  name = params['name']
  @tag.update(name: name)
  if @tag.save
    redirect "/tags/#{@tag.id}"
  else
    erb :error
  end
end


patch '/tag/add_recipe/:id' do
  @tag = Tag.find(params['id'].to_i)
  recipe1 = Recipe.find(params['recipe-id'])
  @tag.recipes.push(recipe1)
  redirect "/tags/#{@tag.id}"
end

post '/recipe_results' do
  input = params['recipe_search']
  @recipe_results = Recipe.recipe_search(input)
  erb :recipe_results
end

get '/ingredient/recipe_results' do
  ingredient = params['ingredient-id'].to_i
  @ingredient = Ingredient.find(ingredient)
  @recipes = @ingredient.recipes
  erb :ingredient_recipes
end
