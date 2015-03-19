class Post < ActiveRecord::Base
	include PublicActivity::Model

	max_paginates_per 50
	
  has_many :images, as: :imageable, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :postable, polymorphic: true

  has_many :loves, as: :loveable, dependent: :destroy

  accepts_nested_attributes_for :images, :allow_destroy => true
end
