class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :authentication_keys => [:username]

  has_many :alts, dependent: :destroy
  has_many :alt_favorites, dependent: :destroy
  #has_many :verifcations, dependent: :destroy
  has_one  :moderator, dependent: :destroy
  validates_uniqueness_of :username


  def after_confirmation
    update(contributor: true, super_user: false, referee: false, flag: false)
    referee = Moderator.create(email: email, first_name: first_name, last_name: last_name, user_id: id, title: email, description: "new sign up", contributor: contributor, super_admin: false, referee: false, flag: false)
    referee.save
  end


end
