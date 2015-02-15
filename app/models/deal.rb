class Deal < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :business
	has_and_belongs_to_many :users
	
	has_many :images, as: :imageable, dependent: :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	validates :business_id, presence: true
	validates :name, presence: true
	validates :price, presence: true
	validates :expires_at, presence: true
	validates :description, presence: true
end
