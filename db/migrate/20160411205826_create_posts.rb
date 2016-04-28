class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :top_text
      t.string :bottom_text

      t.timestamps null: false
    end
  end
end
