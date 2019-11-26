class AdminsController < ApplicationController
  def main
    users = User.all

    names = []
    for user in users
      content = {id: user.id, name: user.name}
      names.push(content)
    end
    @users = names

    annotation = Annotation.all

    @contents = []
    for anno in annotation
      information = anno["information"].split(",")
      content = [anno["id"],anno["path"],information]
      @contents.push(content)
    end

  end

  #前処理の部分テンプレート
  # def preproccess
  # end
  def create_allocation
    puts "------------------------"
    puts params["allocation"]
    # puts allocation_params
    puts "------------------------"
    # {"user"=>"4", "pictures"=>["1", "2", "3"]}

    userId = params["allocation"]["user"]
    pictureId = params["allocation"]["pictures"]

    for pic in pictureId
      allocation = Allocation.new
      allocation.user_id = userId
      allocation.annotation_id = pic
      allocation.save
    end

    users = User.all
    names = []
    for user in users
      content = {id: user.id, name: user.name}
      names.push(content)
    end
    @users = names

    annotation = Annotation.all

    @contents = []
    for anno in annotation
      information = anno["information"].split(",")
      content = [anno["id"],anno["path"],information]
      @contents.push(content)
    end

    render :main

  end

  #割り当ての部分テンプレート
  def allocation

    users = User.all
    names = []
    for user in users
      content = {id: user.id, name: user.name}
      names.push(content)
    end
    @users = names

    annotation = Annotation.all
    @contents = []
    for anno in annotation
      information = anno["information"].split(",")
      content = [anno["id"],anno["path"],information]
      @contents.push(content)
    end

    render :main

  end

  #進捗の部分テンプレート
  def progress
  #0:未割り当て、1:作業中, 2:作業済み



  end

  # private
  # def allocation_params
  #   params.require(:allocation).permit(:user,:pictures)
  # end

end
