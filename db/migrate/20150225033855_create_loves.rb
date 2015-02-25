class CreateLoves < ActiveRecord::Migration
  def change
    create_table :loves do |t|
      t.references :loveable, polymorphic: true, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end

    drop_table :likes
  end
end
