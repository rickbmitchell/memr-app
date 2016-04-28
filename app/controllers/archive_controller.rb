class ArchiveController < ApplicationController

  def index
    @winners = Archive.all
  end

end
