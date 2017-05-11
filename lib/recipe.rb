class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients, dependent: :destroy
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
    input.downcase!
    Recipe.where('lower(title) like ?', "%#{input}%")
  end

end

class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates(:item, {presence: true, :length => { :maximum => 50, :minimum => 3 }})

end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates(:name, presence: true)
end
