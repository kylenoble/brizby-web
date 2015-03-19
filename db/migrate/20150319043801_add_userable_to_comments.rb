class AddUserableToComments < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.references :userable, :polymorphic => true
    end
  end

  def down
    change_table :comments do |t|
      t.remove_references :userable, :polymorphic => true
    end
  end
end
