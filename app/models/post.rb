class Post < ActiveRecord::Base
	include PublicActivity::Model
	
  has_many :images, as: :imageable, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :postable, polymorphic: true

  accepts_nested_attributes_for :images, :allow_destroy => true
end
