class CreateRecipesTags < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes_tags do |r|
      r.integer :recipe_id
      r.integer :tag_id

      r.timestamps
    end
  end
end
