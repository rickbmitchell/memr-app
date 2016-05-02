class Archive < ActiveRecord::Base

  belongs_to :post

  def self.sort_winners
    # 1.week.ago.beginning_of_week..1.week.ago.end_of_week
    weekly_sort = Post.where(:created_at => (1.week.ago..Time.now))
    winner_sort = weekly_sort.sort_by { |post| post.votes.count }.reverse
  end

  def self.archive_winner
    ordered = self.sort_winners
    # top_score = ordered.first.votes.count
    # winners =[]
    # ordered.each do |post|
    #   winners.push post if post.votes.count == top_score
    # end
    puts Archive.create(post_id: ordered.first.id)
  end

  def self.testing
    puts "Testing"
  end


end
