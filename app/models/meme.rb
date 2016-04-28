class Meme < ActiveRecord::Base

  belongs_to :post

  has_attached_file :avatar, :styles =>
  { :medium => "500x500>", :thumb => "100x100>" },
  :default_url => "missing.png", id: "avatar"
  validates_attachment_content_type :avatar,
  content_type: /\Aimage\/.*\Z/

  def self.move_to_next_meme
    current_meme = get_current_meme
    current_meme.update_attribute(:status, 'archived')
    next_image = Meme.where("id > ?", current_meme.id).limit(1).first
    next_image.update_attribute(:status, 'current')
  end

  def self.get_current_meme
    Meme.where("status = 'current'").first
  end

end
