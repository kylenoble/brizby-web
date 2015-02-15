class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :commentable, polymorphic: true
end
