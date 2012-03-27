class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first
      t.string :last
      t.string :phone
      t.string :location

      t.timestamps
    end
  end
end
