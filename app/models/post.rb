class Post < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :business
	has_many :images, as: :imageable, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
end
