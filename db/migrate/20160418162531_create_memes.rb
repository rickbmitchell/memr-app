class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :filename
      t.string :status

      t.timestamps null: false
    end
  end
end
