class Comment < ActiveRecord::Base
	belongs_to :deal
  belongs_to :user
  belongs_to :business
end
