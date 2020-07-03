class CommunityMembership < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :community, foreign_key: "community_id"
end
