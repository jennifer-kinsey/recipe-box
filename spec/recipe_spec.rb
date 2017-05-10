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

  it("returns false if it's too long or too short of a recipe title") do
    test_recipe = Recipe.create({title: "Pi", instructions: "place frozen pot pie in oven", rating: 3})
    expect(test_recipe.save).to eq(false)
    test_recipe2 = Recipe.create({title: "Piheoiufweudhzckuvhuzchivcivycxiyicuyviuxycivuycxiuyicxuyviuyxiuvycivuyxicyv", instructions: "place frozen pot pie in oven", rating: 3})
    expect(test_recipe2.save).to eq(false)
  end

  describe("#titlecase") do
    it("titlecases the title of the recipe") do
      test_recipe = Recipe.create({title: "spaghetti sandwich", instructions: "place frozen pot pie in oven", rating: 3})
      expect(test_recipe.title).to eq("Spaghetti Sandwich")
    end
  end

  it("ensures there are instructions") do
    test_recipe = Recipe.create({title: "spaghetti sandwich", instructions: "", rating: 3})
    expect(test_recipe.save).to eq(false)
  end

  describe("#check_rating") do
    it('ensures the rating value is between 1 and 5') do
      test_recipe = Recipe.create({title: "spaghetti sandwich", instructions: "place frozen pot pie in oven", rating: 20})
      expect(test_recipe.rating).to eq(5)
      test_recipe2 = Recipe.create({title: "spaghetti sandwich", instructions: "place frozen pot pie in oven", rating: -20})
      expect(test_recipe2.rating).to eq(1)
    end
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
