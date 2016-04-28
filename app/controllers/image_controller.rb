class ImagesController < ApplicationController

  def index
    images_dir = Rails.root.join('public', 'images')

    @images = []

    Dir.entries(images_dir).each do |file|
      if (File.file?(images_dir.to_s + '/' + file))
        @images.push('/images/' + file)
      end
    end
  end

  def imgur

    require 'httparty'

    url = 'https://api.imgur.com/3/gallery/hot/hot/1'
    headers = {'Authorization' => 'Client-ID ' + '22fc92366c921f4'}
    resp = HTTParty.get(url, query: {}, headers: headers).parsed_response

    resp['data'].each do |image|
      unless image['type'].blank?
        image_path = Rails.root.join('public', 'images', image['link'].split('/')[-1])
        puts "image type: #{image['type'].blank?}"

        unless File.exists?(image_path)
          open(image_path.to_s, 'wb') do |file|
            file << open(image['link']).read
          end
        end
      end
    end

    render json: resp
  end

end

# 22fc92366c921f4 + 493cf83f7c009365fd03b3f433927588632a10dc