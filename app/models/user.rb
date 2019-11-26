class User < ApplicationRecord
  validates :name, presence: {message: "%{value}を入力してください"}
  validates :password, presence: {message: "%{value}を入力してください"}
  has_secure_password

  #名前の文字数制限
  validates :name, length: {maximum: 15, message: "は15文字以内にしてください"}

  #パスワードの文字数制限
  validates :password, length: {in: 8..32, too_long:"は32文字以内にしてください", too_short:"は8文字以上にしてください"}
  validates :password, format: {with: /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)/, message: "%{value}はアルファベット（大小）と半角数字の混合にしてください"}

  #パスワードが一致しているかの確認
  validates :password, confirmation: {message: "とpasswordの値が一致していません"}

  #アソシエーション
  has_many :annotations
  has_many :allocations
  has_many :allocation_annotations, through: :allocations, source: 'annotation'

end
