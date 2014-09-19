class User < ActiveRecord::Base
  validates_presence_of :full_name
  validates :full_name, uniqueness: true
  validates_presence_of :email
  validates :email, uniqueness: true
  validates_presence_of :password
  has_many :blahs
  has_many :followers, through: :follower_follows, source: :follower
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
end
