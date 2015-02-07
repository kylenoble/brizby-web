class AddAttachmentImageToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :image
      t.belongs_to :business
    end
    add_index :images, :business_id
  end

  def self.down
    remove_attachment :images, :image
  end
end
