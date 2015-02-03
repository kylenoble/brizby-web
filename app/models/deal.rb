class Deal < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :businesses
	has_and_belongs_to_many :users

	validates :business_id, presence: true
	validates :name, presence: true
	validates :price, presence: true
	validates :expires_at, presence: true
	validates :description, presence: true
end
