class AdminsController < ApplicationController
  def main
  end

  #前処理の部分テンプレート
  def preproccess
  end

  #割り当ての部分テンプレート
  def allocation
    @users = User.all
  end

  #進捗の部分テンプレート
  def progress
  end

end
