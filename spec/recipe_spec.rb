require "spec_helper"

describe(Recipe) do
  it("has many ingredients") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_ingred1 = Ingredient.create({:item => "Stouffers Frozen Pot Pie!", recipe_id: test_recipe.id})
    test_ingred2 = Ingredient.create({:item => "salt", recipe_id: test_recipe.id})
    expect(test_recipe.ingredients).to eq([test_ingred1, test_ingred2])
  end
  it("has many tags") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_tag1 = Tag.create({name: "salty"})
    test_tag2 = Tag.create({name: "spicy"})
    test_tag3 = Tag.create({name: "fattening"})
    test_recipe.tags.push(test_tag1, test_tag2, test_tag3)
    expect(test_recipe.tags).to eq([test_tag1, test_tag2, test_tag3])
  end
end

describe(Ingredient) do
  it("has a recipe") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_ingred1 = Ingredient.create({:item => "Stouffers Frozen Pot Pie!", recipe_id: test_recipe.id})
    test_ingred2 = Ingredient.create({:item => "salt", recipe_id: test_recipe.id})
    expect(test_ingred1.recipe).to eq(test_recipe)
    expect(test_ingred2.recipe).to eq(test_recipe)
  end
  it("returns recipes by ingredient") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_ingred = Ingredient.create({:item => "Stouffers Frozen Pot Pie!", recipe_id: test_recipe.id})
    expect(test_ingred.recipe).to eq(test_recipe)
  end
end

describe(Tag) do
  it("has many recipes") do
    test_tag = Tag.create(name: "Mexican")
    test_recipe1= Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_recipe2= Recipe.create({title: "Yakisoba Burrito", instructions: "do stuff", rating: 3})
    test_recipe3= Recipe.create({title: "Disappointing Tacos", instructions: "throw away", rating: 1})
    test_tag.recipes.push(test_recipe1, test_recipe2, test_recipe3)
    expect(test_tag.recipes).to eq([test_recipe1, test_recipe2, test_recipe3])
  end
end
