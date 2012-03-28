class Client < ActiveRecord::Base
	validates :first, :presence => true
	validates :last, :presence => true
	validates :phone, :presence => true
	validates :address, :presence => true
	validates :city, :presence => true
	validates :state, :presence => true, :length => { :minimum => 2, :maximum => 2}
end
