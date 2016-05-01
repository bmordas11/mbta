class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :name, null: false
      t.integer :number_trains

      t.timestamps null: false
    end
  end
end
