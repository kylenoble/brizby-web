class Followship < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :user
	belongs_to :user_followed, class_name: "User"
	belongs_to :business_followed, class_name: "Business"
end