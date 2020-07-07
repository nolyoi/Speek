# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  belongs_to :following, foreign_key: :following_id, class_name: 'User', optional: true

  validates :follower_id, presence: true
  validates :following_id, presence: true
  
  before_save :prevent_double_follow

  acts_as_notifiable :users,
                     targets: :custom_notification_users,
                     group: :article,
                     notifier: :user,
                     email_allowed: :custom_notification_email_to_users_allowed?,
                     notifiable_path: :custom_notifiable_path

  private

  def prevent_double_follow
    user_check = Follow.where('follower_id = ? AND following_id = ?', follower_id, following_id)

    if user_check != []
      errors.add(:base, 'You cannot double follow that user!')
      delete
    end
  end

  # def create_membership_on_follow
  # 	if self.following_community_id
  # 		membership = CommunityMembership.create(user_id: self.follower_id, community_id: self.following_community_id)
  # 	end
  # end
end
