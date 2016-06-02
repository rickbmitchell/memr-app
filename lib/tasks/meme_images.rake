namespace :meme_images do
  desc "TODO"
  task run: :environment do
    Meme.destroy_all
    count = 0 #TESTING ONLY
    Dir.glob(Rails.root + "public/images/*.{jpg,png}") do |item|
      next if item == '.' or item == '..' or count >= 4
      @meme = Meme.create
      @meme.avatar = File.open(item)
      @meme.save
      count +=1
    end
    Meme.first.update_attribute(:status, 'current')
  end

  # task test: :environment do
  #   puts Meme.first.get_info
  # end
end

