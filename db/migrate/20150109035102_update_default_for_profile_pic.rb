class UpdateDefaultForProfilePic < ActiveRecord::Migration
  def change
  	change_column :profile_pics, :processed, :bool, :default => false, :null => false
  end
end
