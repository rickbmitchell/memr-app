include Magick

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_one :meme
  has_one :archive


  has_attached_file :avatar, :styles =>
  { :medium => "400x400>", :thumb => "100x100>" },
  :default_url => "missing.png", id: "avatar"
  validates_attachment_content_type :avatar,
  content_type: /\Aimage\/.*\Z/

  validates :top_text, length: { maximum: 34 }
  validates :bottom_text, length: { maximum: 17 }


  MAX_LINE_CHARACTERS=17
  MAX_CHARACTERS=34


  def to_param
    "#{id}-#{user_id}"
  end

  # def last_week
  #   where(:created_at => (1.week.ago.beginning_of_week..1.week.ago.end_of_week)
  # end

  # def winner
  #   @post = Post.all.where(:created_at => (Time.zone.now.beginning_of_week..Time.zone.now.end_of_week))
  #   @winner = @post.votes.count.reverse.first(1)
  # end

  def top_line_meme(top)
    two_line_meme(top)
  end

  def bottom_line_meme(bottom)
    two_line_meme(nil, bottom)
  end

  def two_line_meme(top, bottom=nil)

    if (top.length > MAX_CHARACTERS || bottom.length > MAX_LINE_CHARACTERS)
      raise "Too many characters"
    end

    if (top.length > MAX_LINE_CHARACTERS)

      top_parts = top.split(' ')
      count = 0
      top_top = ""
      bottom_top = ""

      top_parts.each do |part|
        if count + (part.length + 1) < MAX_LINE_CHARACTERS
          top_top += " " + part
          count += part.length + 1
        else
          bottom_top += " " + part
        end
      end

      top = top_top + "\n" + bottom_top
    end

      img = Image.read(File.open(Meme.get_current_meme.avatar.path)).first

      caption = Draw.new

      caption.font = 'lib/assets/ufonts.com_impact.ttf'
      caption.fill = 'white'
      caption.pointsize = 50
      caption.font_weight = BoldWeight
      caption.stroke = 'black'
      caption.stroke_width = 3

      if (top)
        caption.annotate(img, 0,0,0,10, top.upcase) do
          self.gravity = NorthGravity
        end
      end

      if (bottom)
        caption.annotate(img, 0,0,0,10, bottom.upcase) do
          self.gravity = SouthGravity
        end
      end

      img.write(Rails.root + "public/memes/#{to_param}entry.jpg")

    end

end
