class User < ApplicationRecord
  has_secure_password
  acts_as_target
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :echoes, foreign_key: "echoer_id"

  has_many :communities, foreign_key: 'admin_id'
  has_many :community_memberships
  has_many :memberships, through: :community_memberships, source: :community

  has_many :received_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :received_follows, source: :follower

  has_many :follows_given, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :follows_given, source: :following

  has_one_attached :avatar

  
  
  def password=(new_password)
    salt = BCrypt::Engine::generate_salt
    hashed = BCrypt::Engine::hash_secret(new_password, salt)
    self.password_digest = salt + hashed
  end
 
  # authenticate(password: string) -> User?
  def authenticate(password)
    # Salts generated by generate_salt are always 29 chars long.
    salt = password_digest[0..28]
    hashed = BCrypt::Engine::hash_secret(password, salt)
    return nil unless (salt + hashed) == self.password_digest
  end


end
