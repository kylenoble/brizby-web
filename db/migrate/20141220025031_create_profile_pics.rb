class CreateProfilePics < ActiveRecord::Migration
  def change
    create_table :profile_pics do |t|
    	t.belongs_to :user
    	t.belongs_to :business 
      t.timestamps
    end
    add_index :profile_pics, :user_id
  	add_index :profile_pics, :business_id
  end
end
