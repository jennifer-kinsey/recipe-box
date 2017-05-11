class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :tags
  validates(:title, {:presence => true, :length => { :maximum => 50, :minimum => 3 }})
  validates(:instructions, presence: true)
  validates(:rating, presence: true)
  before_save(:titlecase, :check_rating)


private
  define_method(:titlecase) do
    words = self.title.split(" ")
    words.each do |word|
      word.capitalize!
    end
    self.title = words.join(" ")
  end

  def check_rating
    if(self.rating > 5)
      self.rating = 5
    elsif self.rating < 1
      self.rating = 1
    end
  end

  def self.recipe_search(input)
    Recipe.where('title like ?', "%#{input}%")
  end


  def self.ingredient_search(input)
    recipes = Recipe.all
    found_recipes = []
    recipes.each do |recipe|
      found_recipes = Recipe.where('recipe.ingredients.item like ?', "%#{input}%")
    end
    found_recipes
  end

end

class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates(:item, {:presence => true, :length => { :maximum => 50, :minimum => 3 }})

end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates(:name, presence: true)
end
