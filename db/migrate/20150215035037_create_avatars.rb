class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.boolean :processed, default: false, null: false 
      t.string :direct_upload_url, null: false
      t.references :avatarable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
