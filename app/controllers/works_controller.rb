class WorksController < ApplicationController
  def main
    @user_name = current_user.name
    @picture = Picture.new
    # binding.pry
  end

end
