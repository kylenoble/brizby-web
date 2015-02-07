class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.belongs_to :business
      t.timestamps
    end
    add_index :posts, :business_id
  end
end
