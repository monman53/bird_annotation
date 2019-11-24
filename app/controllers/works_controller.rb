class WorksController < ApplicationController
  def main
    @user_name = current_user.name
    @picture = Picture.all
    # binding.pry
  end

end
