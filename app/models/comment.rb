class Comment < ActiveRecord::Base
	max_paginates_per 50
	
  belongs_to :user
  belongs_to :business
  belongs_to :commentable, polymorphic: true
end
