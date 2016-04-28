namespace :meme_images do
  desc "TODO"
  task run: :environment do
    Meme.destroy_all
    Dir.glob(Rails.root + "public/images/*.{jpg,png}") do |item|
      next if item == '.' or item == '..'
      @meme = Meme.create
      @meme.avatar = File.open(item)
      @meme.save
    end
    Meme.first.update_attribute(:status, 'current')
  end
end
