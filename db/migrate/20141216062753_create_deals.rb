class CreateDeals < ActiveRecord::Migration
  def up
    create_table :deals do |t|
      t.string :name
      t.float :price
      t.datetime :expires_at
      t.text :description
      t.belongs_to :business
      t.timestamps
    end
    add_index :deals, :business_id

    create_table :deals_users do |t|
    	t.belongs_to :deal
      t.belongs_to :user
    end
    add_index :deals_users, [:deal_id, :user_id]
    add_index :deals_users, :user_id
  end
  def down
  	drop_table :deals
  	drop_table :deals_users
  end
end
