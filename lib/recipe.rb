class Recipe < ActiveRecord::Base
  has_many :ingredients
end

class Ingredient < ActiveRecord::Base
  belongs_to :recipe
end

class Tag < ActiveRecord::Base
end
