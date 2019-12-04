class WorksController < ApplicationController
  # include gon

  def main
    # @user_name = current_user.name

    @user_state=[]
    #アノテーション画像を取得する
    allos = current_user.allocation_annotations

    #selectでstate==2(作業中)のものを選別する
    user_state = allos.select{|i| i.state == 2 }

    #working状態の画像の数を取得
    @count = user_state.count

    #userの情報を配列に入れる(@countが0のときはerrorになるかもしれないので除外)
    if @count != 0
        @user_state = [user_state[0].id, user_state[0].path, user_state[0].information]
    end

    #進捗率を計算する
    total = allos.count
    if total == 0
      #ユーザー名と、進捗率を入れる
      @progress = [current_user.name, 0]
    else
      end_all = allos.select{|i| i.state == 3 }.count
      @progress = [current_user.name, ((end_all.to_f / total.to_f)*100).ceil]
    end
  end

  def action

    anno = Annotation.find(params["img_id"].to_i)
    categoryId = params["judege"].to_i

    #cateogryidに応じた文字列を取得
    if categoryId == 1
      categoryStr = 'b'
    elsif categoryId == 2
      categoryStr = 'n'
    else
      categoryStr = 'u'
    end

    newInfo = params["info"][0..-2]+categoryStr

    # アノテーションの状態を終了(state: 3)に変更する
    anno.update_attribute(:state, 3)
    #カテゴリーの種類を変更する
    anno.update_attribute(:category_id, params["judege"].to_i)
    #情報を更新する
    anno.update_attribute(:information, newInfo)

    redirect_to works_main_path

  end

end
