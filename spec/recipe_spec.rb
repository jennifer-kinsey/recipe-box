require "spec_helper"

describe(Recipe) do
  it("has a title") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    expect(test_recipe.title).to eq(test_recipe.title)
  end
  it("has many ingredients") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_ingred1 = Ingredient.create({:item => "Stouffers Frozen Pot Pie!", recipe_id: test_recipe.id})
    test_ingred2 = Ingredient.create({:item => "salt", recipe_id: test_recipe.id})
    expect(test_recipe.ingredients).to eq([test_ingred1, test_ingred2])
  end
end
