class ChangeFollowshipColumns < ActiveRecord::Migration
  def change
  	rename_column :followships, :user_follow_id, :user_followed_id
  	rename_column :followships, :business_follow_id, :business_followed_id
  end
end
