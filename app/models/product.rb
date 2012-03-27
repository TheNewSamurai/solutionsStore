class Product < ActiveRecord::Base
	validates :name, :presence => true
	validates :model, :presence => true
	
	belongs_to :list
end
