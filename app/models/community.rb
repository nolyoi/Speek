# frozen_string_literal: true

class Community < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :description]

  belongs_to :user, foreign_key: 'admin_id'

  has_many :posts, foreign_key: 'community_id'
  has_many :followers, class_name: 'Follow', foreign_key: 'following_community_id', dependent: :destroy
  has_many :community_memberships
  has_many :users, through: :community_memberships, source: :user

  has_one_attached :avatar
  has_one_attached :header_image

  validates :name, presence: true, uniqueness: true

  after_create :add_community_membership

  private

  def add_community_membership
    cm = CommunityMembership.create(user_id: admin_id, community_id: id, role: 2)
  end

  def self.is_member?
    community = communities.where(comm)
  end
end
