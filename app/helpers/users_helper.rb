module UsersHelper

  def is_following?(user)
    follow = user.follows_given.find_by(following_id: user.id)
    follow.presence ? true : false
  end

  def is_admin?(user)
    user.role == "admin"
  end

  def dashboard_activity_posts(user)
    activity = []

    # Searching through users.
    user.following.each do |following|
      activity.concat(following.posts)  
    end

    # 
    user.communities.each do |community|
      community.posts.each do |commpost|
        activity.concat(comm.posts) unless commpost.user_id == user.id
      end
    end  

    activity = activity.sort_by{|e| e[:created_at]}.reverse
  end

  private

end
