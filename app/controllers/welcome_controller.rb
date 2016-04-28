class WelcomeController < ApplicationController

  def index
    if current_user && !current_user.profile
      redirect_to new_profile_path
    end
  end

end
