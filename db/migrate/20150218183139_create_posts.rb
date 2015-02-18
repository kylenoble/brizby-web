class CreatePosts < ActiveRecord::Migration
  def change
    drop_table :posts
    create_table :posts do |t|
      t.text :body
      t.references :postable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
