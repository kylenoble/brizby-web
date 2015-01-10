class AddUrlToProfilePics < ActiveRecord::Migration
  def up
    add_column :profile_pics, :direct_upload_url, :string, :null => false
    add_column :profile_pics, :processed, :bool, :null => false
    add_index :profile_pics, :processed
  end
  def down
    remove_column :profile_pics, :direct_upload_url
    remove_column :profile_pics, :processed
  end
end
