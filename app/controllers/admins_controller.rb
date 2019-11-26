class AdminsController < ApplicationController
  def main

    #ユーザー一覧を取得
    users = User.all
    names = []
    for user in users
      content = {id: user.id, name: user.name}
      names.push(content)
    end
    @users = names

    #アノテーション画像の一覧を取得
    annotation = Annotation.all
    annotation = annotation.select{|i| i.state == 1 }
    @contents = []
    for anno in annotation
      information = anno["information"].split(",")
      content = [anno["id"],anno["path"],information]
      @contents.push(content)
    end

    #割り当てられた作業を表示
    #ユーザーをすべて取得
    users = User.all

    @progress=[]
    for user in users

      #ユーザーに紐付いたannotationsを取得
      allos = user.allocation_annotations
      #annotationの数量
      total = allos.count

      if total == 0
        next
      end

      end_all = allos.select{|i| i.state == 3 }.count
      content = [user.name, ((end_all.to_f / total.to_f)*100).ceil]
      @progress.push(content)
    end

  end

  #前処理の部分テンプレート
  # def preproccess
  # end
  def create_allocation

    #allocationテーブルに保存する
    userId = params["allocation"]["user"]
    pictureId = params["allocation"]["pictures"]

    for pic in pictureId
      allocation = Allocation.new
      allocation.user_id = userId
      allocation.annotation_id = pic
      allocation.save

      anno = Annotation.find(pic)
      #2:作業中に変更する
      anno.update_attribute(:state, 2)
    end

    redirect_to admins_main_path

  end

  #割り当て
  # def allocation
  # end

  #進捗の部分テンプレート
  # def progress
  # end

  # private
  # def allocation_params
  #   params.require(:allocation).permit(:user,:pictures)
  # end

end
