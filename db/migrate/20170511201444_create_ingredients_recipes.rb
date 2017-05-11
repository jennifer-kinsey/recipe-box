class CreateIngredientsRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients_recipes do |r|
      r.integer :ingredient_id
      r.integer :recipe_id

      r.timestamps
    end
    remove_column(:ingredients, :recipe_id, :integer)
  end
end
