class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first
      t.string :last
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
	  t.string :latitude
	  t.string :longitude

      t.timestamps
    end
  end
end
