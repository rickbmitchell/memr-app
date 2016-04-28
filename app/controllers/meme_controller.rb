class MemeController < ApplicationController

  # def new
  #   @meme = Meme.new
  # end

  # def create
  #   @meme = Meme.create(meme_params)
  #   Dir.glob(Rails.root + "public/images/*.{jpg,png}") do |item|
  #     next if item == '.' or item == '..'
  #     @meme.avatar = File.open(item)
  #     @meme.save
  #   end
  # end

  # private

  # def meme_params
  #   params.require(:meme).permit(:filename, :status, :avatar)
  # end

end
