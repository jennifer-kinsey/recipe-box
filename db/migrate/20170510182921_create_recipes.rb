class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |r|
      r.string :title
      r.string :instructions
      r.integer :rating

      r.timestamps
    end
  end
end
