# frozen_string_literal: true

module CommunitiesHelper
  def is_community_admin?(user, community)
    c = user.community_memberships.find_by(community_id: community.id, role: 2)
    c ? true : false
  end

  def is_community_moderator?(user, community)
    c = user.community_memberships.where(community_id: community.id)
    c.role == 1
  end

  def is_community_member?(user, community)
    c = user.community_memberships.find_by(community_id: community.id)
    c ? true : false
  end

  def community_role(user, community)
    if user.community_memberships.find_by(community_id: community.id, role: 'admin')
      'Admin'
    elsif user.community_memberships.find_by(community_id: community.id, role: 'moderator')
      'Moderator'
    elsif user.community_memberships.find_by(community_id: community.id, role: 'member')
      'Member'
    end
  end

  def get_admins(community)
    admins = CommunityMembership.where(community_id: community.id, role: 2)

    admins.collect do |admin|
      User.find(admin.user_id)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_community
    @community = if params[:community_id]
                   Community.find(params[:community_id])
                 else
                   Community.find(params[:id])
                 end
  end
end
