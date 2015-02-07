class AddUrlToImages < ActiveRecord::Migration
  def up
  	add_column :images, :direct_upload_url, :string, :null => false
    add_column :images, :processed, :bool, :null => false
    add_index :images, :processed
  end
  def down
  	remove_column :images, :direct_upload_url
    remove_column :images, :processed
  end
end
