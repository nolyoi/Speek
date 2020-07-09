# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true
    can :read, User
    cannot :read, Message

    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can :read, Post, user_id: user.id

      can :manage, User, id: user.id
      can :dashboard, User
      can :read, User

      can :manage, Message, to_id: user.id
      can :manage, Message, from_id: user.id

      # if user.admin?  # additional permissions for administrators
      #   can :read, Post
      # end
    end
  end
end
