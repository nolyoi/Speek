# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true
    can :read, User

    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can :read, Post, user_id: user.id
      can :dashboard, User
      can :manage, User, id: user.id
      can :read, User

      # if user.admin?  # additional permissions for administrators
      #   can :read, Post
      # end
    end
  end
end
