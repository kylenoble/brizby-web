class AddTaggedBusinessToPosts < ActiveRecord::Migration
  def up
  	add_column :posts, :tagged_business, :integer
  	add_index :posts, :tagged_business
  end
  def down
  	remove_column :posts, :tagged_business
  end
end
