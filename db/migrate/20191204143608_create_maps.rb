class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
      t.string :state
      t.string :population
      t.string :abbreviation
      t.decimal :lng
      t.decimal :lat

      t.timestamps
    end
  end
end
