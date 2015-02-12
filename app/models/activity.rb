class Activity < ActiveRecord::Base

	belongs_to :deal, :foreign_key => "trackable_id"
	#belongs_to :deal, :foreign_key => "recipient_id"
	belongs_to :post, :foreign_key => "trackable_id"
	belongs_to :post, :foreign_key => "recipient_id"
	belongs_to :user, :foreign_key => "owner_id"
	belongs_to :user, :foreign_key => "recipient_id"
	belongs_to :business, :foreign_key => "owner_id"
	#belongs_to :business, :foreign_key => "recipient_id"
	belongs_to :comment, :foreign_key => "trackable_id"

	paginates_per 5
end