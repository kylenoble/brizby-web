class AddLatToActivities < ActiveRecord::Migration
  def up
  	add_column :activities, :latitude, :float
  	add_column :activities, :longitude, :float
  	add_index :activities, :latitude
  	add_index :activities, :longitude
  end
  def down
  	remove_column :activities, :latitude
  	remove_column :activities, :longitude
  end
end
