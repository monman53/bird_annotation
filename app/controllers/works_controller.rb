class WorksController < ApplicationController
  def main
    @user_name = current_user.name
  end


end
