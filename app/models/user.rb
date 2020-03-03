class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :tweets

  has_many :user_follows, foreign_key: :user_id, class_name: 'Follow'
  has_many :follow_follows, foreign_key: :follow_id, class_name: 'Follow'

  # FOLLOW/ FOLLOWING
  has_many :followers, through: :follow_follows, source: 'follower_user'
  has_many :following, through: :user_follows, source: 'following_user'

  validates :username, uniqueness: { case_sensitive: false } # Optional

  def name
    return self.username if self.username.present?
    return self.email if self.email.present?
  end

  def following?(user)
    following.find_by(id: user.id).present?
  end

  # NOTE: for devise login with username
  attr_writer :login
  def login
    @login || self.username || self.email
  end
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
