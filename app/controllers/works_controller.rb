class WorksController < ApplicationController
  def main
    # @user_name = current_user.name

    @user_state=[]
    allos = current_user.allocation_annotations
    #selectでstate==1(作業中)のものを選別する

    if allos.count==0
      @user_state = [0]
    else
      user_state = allos.select{|i| i.state == 2 }[0]
      @user_state = [user_state.id, user_state.path, user_state.information]
    end

    # for allo in allos
    #   #アノテーションの要素
    #   @user_state.push([allo.id, allo.path, allo.information])
    # end

    total = allos.count
    if total == 0
      @progress = [current_user.name, 0]
    else
      end_all = allos.select{|i| i.state == 3 }.count
      @progress = [current_user.name, ((end_all.to_f / total.to_f)*100).ceil]
    end
  end

end
