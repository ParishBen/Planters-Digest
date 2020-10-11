class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.string :plant_type
      t.string :nickname
      t.integer :user_id

      t.timestamps
    end
  end
end
