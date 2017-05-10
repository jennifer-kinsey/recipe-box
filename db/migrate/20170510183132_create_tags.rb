class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |r|
      r.string :name

      r.timestamps
    end
  end
end
