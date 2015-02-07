class CreateImagesTable < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :post
      t.belongs_to :deal
      t.text :caption
    end
    add_index :images, :post_id
    add_index :images, :deal_id
  end
end
