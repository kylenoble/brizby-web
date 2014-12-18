class Deal < ActiveRecord::Base
	belongs_to :businesses
	has_and_belongs_to_many :users
end
