module CommunitiesHelper

  def is_community_admin?(user, community)
    c = user.community_memberships.find_by(community_id: community.id, role: 2)
    c ? true : false
  end

  def is_community_moderator?(user, community)
    c = user.community_memberships.where(community_id: community.id)
    c.role == 1 ? true : false
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
    @community = Community.find(params[:id])
  end
end
