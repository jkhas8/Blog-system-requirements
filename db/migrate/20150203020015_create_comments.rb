class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :entry, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :comments, [:entry_id, :user_id]
  end
end
