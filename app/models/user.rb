class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :relationships, foreign_key: :following_id #フォローする側からのhas_many
  # relationshipsだけだとフォローする側からなのかされる側なのかわからないのでforeign_keyを設定
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id　 #フォローされる側からのhas_many
  # フォローする側からのアソシエーションと区別するためにreverse_of_relationships
  # class_name: 'Relationship'の記述がないと、railsはreverse_of_relationshipsテーブルを探す
  
  has_many :followings, through: :relationships, source: :follower　#中間テーブルを介してフォローされる人を取ってくる
  # あるユーザーがフォローしている人を全員取ってくる（フォロー一覧）
  has_many :followers,　through: :reverse_of_relationships, source: :following
  # あるユーザーをフォローしてくれている人を全員取ってくる（フォロワー一覧）
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
   validates :introduction, length: { maximum: 50 }

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  
end
