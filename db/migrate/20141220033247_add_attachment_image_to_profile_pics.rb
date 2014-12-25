class AddAttachmentImageToProfilePics < ActiveRecord::Migration
  def self.up
    change_table :profile_pics do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :profile_pics, :image
  end
end
