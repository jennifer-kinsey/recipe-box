class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_and_belongs_to_many :tags
end

class Ingredient < ActiveRecord::Base
  belongs_to :recipe
end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes
end
