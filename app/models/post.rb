class Post < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :business
	has_many :images
end
