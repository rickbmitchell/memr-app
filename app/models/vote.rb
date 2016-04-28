class Vote < ActiveRecord::Base

  belongs_to :post
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :post_id }
  # validates_uniqueness_of :user_ip_address, scope: :post_id

end
