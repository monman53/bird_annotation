class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: name_params[:name])
    if user && user.authenticate(password_params[:password])
      log_in user
      redirect_to works_main_path, success: 'ログインしました'
    else
      flash.now[:danger]='ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, info: 'ログアウトしました'
  end

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def name_params
    params.require(:session).permit(:name)
  end

  def password_params
    params.require(:session).permit(:password)
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
