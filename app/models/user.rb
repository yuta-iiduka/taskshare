class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :profile_image
  has_many :post_files, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_post_files, through: :favorites, source: :post_file
  has_many :post_commented_post_files, through: :post_comments, source: :post_file
  has_many :memos, dependent: :destroy
  
  #検索機能（かつ，または）
  def self.search(search,word)
    if search == "forward_match"
      @users = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @users = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @users = User.where("name LIKE?","#{word}")
    elsif search == "partial_match"
      @users = User.where("name LIKE?","%#{word}%")
    else
      @users = User.all
    end
  end
end
