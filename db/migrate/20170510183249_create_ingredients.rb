class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |r|
      r.string :item
      r.integer :recipe_id

      r.timestamps
    end
  end
end
