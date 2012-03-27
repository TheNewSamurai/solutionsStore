class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :upc
      t.string :name
      t.string :model
      t.string :quantity

      t.timestamps
    end
  end
end
