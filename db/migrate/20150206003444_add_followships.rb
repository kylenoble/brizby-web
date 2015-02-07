class AddFollowships < ActiveRecord::Migration
  def change
  	create_table :followships do |t|
      t.belongs_to :user
      t.belongs_to :user_follow
      t.belongs_to :business_follow

      t.timestamps
    end
    add_index :followships, :user_follow_id
    add_index :followships, :business_follow_id
  end
end
