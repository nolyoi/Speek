# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :username]

  has_secure_password
  acts_as_target

  enum role: { user: 0, moderator: 1, admin: 2 }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :echoes, foreign_key: 'echoer_id'

  has_many :communities, foreign_key: 'admin_id'
  has_many :community_memberships
  has_many :memberships, through: :community_memberships, source: :community

  has_many :received_follows, class_name: 'Follow', foreign_key: 'following_id', dependent: :destroy
  has_many :followers, through: :received_follows, source: :follower

  has_many :follows_given, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :follows_given, source: :following

  has_many :participants, class_name: 'Private::Participant'
  has_many :conversations, through: :participants, class_name: 'Private::Conversation'
  has_many :messages, class_name: 'Private::Message'

  has_one_attached :avatar
  has_one_attached :header_image

  validates :username, uniqueness: true, presence: true, length: { minimum: 3, maximum: 14 }, format: { with: /\A[\w-]+\z/, 
                                                                                                        message: "Invalid username. Please choose another!" }
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { in: 8..50 }
  validates :bio, length: { maximum: 200 }

  def first_name
    self.name.split(' ')[0]
  end

  private

  def self.create_with_omniauth(auth)
    create! do |user|
      username = auth['info']['name'].to_s.split
      username = username[0] + rand(100..1000).to_s

      user.provider = auth['provider']
      user.uid = auth['uid']
      user.username = username
      user.email = auth['info']['email']
      user.password = auth["uid"] + username
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end
end
