class AddCategoryToBusinessAndAcitivites < ActiveRecord::Migration
  def up
  	add_column :activities, :category, :string
  	add_column :businesses, :category, :string
  	add_index :activities, :category
  	add_index :businesses, :category
  end
  def down
  	remove_column :activities, :category
  	remove_column :businesses, :category
  end
end
