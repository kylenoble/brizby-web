class Followship < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :user
	belongs_to :user_follow, class_name: "User"
	belongs_to :business_follow, class_name: "Business"
end