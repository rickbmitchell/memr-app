class CreateArchivedPosts < ActiveRecord::Migration
  def change
    create_table :archived_posts do |t|
      t.integer :post_id
      t.integer :archive_id

      t.timestamps null: false
    end
  end
end
