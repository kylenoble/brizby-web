class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.boolean :processed, default: false, null: false 
      t.string :direct_upload_url, null: false
      t.text :caption
      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
