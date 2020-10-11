class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.integer :plant_id
      t.string :condition_update
      t.date :water_date
      t.string :notes

      t.timestamps
    end
  end
end
