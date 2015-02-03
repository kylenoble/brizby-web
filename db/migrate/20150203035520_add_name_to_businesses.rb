class AddNameToBusinesses < ActiveRecord::Migration
  def up
  	add_column :businesses, :name, :string
  end
  def down
  	remove_column :businesses, :name
  end
end
