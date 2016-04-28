class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
