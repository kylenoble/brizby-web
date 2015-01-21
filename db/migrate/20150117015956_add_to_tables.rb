class AddToTables < ActiveRecord::Migration
  def up
    add_column :users, :home_city, :string
    add_column :businesses, :full_address, :string
    add_column :businesses, :phone_number, :string
    add_column :businesses, :about, :text
    add_column :businesses, :latitude, :float
    add_column :businesses, :longitude, :float
  end
  def down
    remove_column :users, :home_city
    remove_column :businesses, :full_address
    remove_column :businesses, :phone_number
    remove_column :businesses, :about
    remove_column :businesses, :latitude
    remove_column :businesses, :longitude
  end
end
