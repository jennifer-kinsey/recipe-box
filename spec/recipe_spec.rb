require "spec_helper"

describe(Recipe) do
  it { should have_and_belong_to_many(:ingredients) }
  it { should have_and_belong_to_many(:tags) }
  it { should validate_presence_of(:title) }

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

  describe("#check_rating") do
    it('ensures the rating value is between 1 and 5') do
      test_recipe = Recipe.create({title: "spaghetti sandwich", instructions: "place frozen pot pie in oven", rating: 20})
      expect(test_recipe.rating).to eq(5)
      test_recipe2 = Recipe.create({title: "spaghetti sandwich", instructions: "place frozen pot pie in oven", rating: -20})
      expect(test_recipe2.rating).to eq(1)
    end
  end

  describe(".recipe_search") do
    it('searches through all the recipes and returns matches based on title') do
      test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
      test_recipe2 = Recipe.create({title: "Chicken Chalupa", instructions: "order and eat", rating: 4})
      expect(Recipe.recipe_search("Chicken")).to eq([test_recipe, test_recipe2])
    end
  end

  it('shows all recipes that an ingredient is used in') do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_recipe2 = Recipe.create({title: "Chicken Chalupa", instructions: "order and eat", rating: 4})
    test_ingredient = Ingredient.create({:item => "salt"})
    test_ingredient.recipes.push(test_recipe)
    test_ingredient.recipes.push(test_recipe2)
    expect(test_ingredient.recipes).to eq([test_recipe, test_recipe2])
  end

end


describe(Ingredient) do
    it { should have_and_belong_to_many(:recipes) }
    it { should validate_presence_of(:item) }

  it("returns recipes by ingredient") do
    test_recipe = Recipe.create({title: "Chicken Pot Pie", instructions: "place frozen pot pie in oven", rating: 3})
    test_ingred = Ingredient.create({:item => "Stouffers Frozen Pot Pie!"})
    test_ingred.recipes.push(test_recipe)
    expect(test_ingred.recipes).to eq([test_recipe])
  end

  it('ensures that the ingredient is not too long') do
    test_ingred = Ingredient.create({:item => "kaikuoisuoiuzvoduvoiuxocuvoixucvoiuzfghrlkhrnakjhruybvuovucortnrksjh;buo;iguoueijkjghlxfh"})
    expect(test_ingred.save).to eq(false)
  end

  it('ensures that the ingredient is not too short') do
    test_ingred = Ingredient.create({:item => "a"})
    expect(test_ingred.save).to eq(false)
  end

end

describe(Tag) do
  it { should have_and_belong_to_many(:recipes) }
  it { should validate_presence_of(:name) }
end
