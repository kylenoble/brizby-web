class RemoveNilFromAvatarDUrl < ActiveRecord::Migration
  def up
  	change_column :avatars, :direct_upload_url, :string, :null => true
  end
  def down
  	change_column :avatars, :direct_upload_url, :string, :null => false
  end
end
