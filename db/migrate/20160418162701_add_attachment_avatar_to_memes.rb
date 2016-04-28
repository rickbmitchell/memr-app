class AddAttachmentAvatarToMemes < ActiveRecord::Migration
  def self.up
    change_table :memes do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :memes, :avatar
  end
end
