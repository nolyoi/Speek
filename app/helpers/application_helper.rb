# frozen_string_literal: true

module ApplicationHelper
  def hundred_char_limit(text)
    truncate(strip_tags(text), length: 100)
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def require_login
    unless session.include? :user_id
      redirect_to login_path,
                  { warning: 'You must be logged in access that page' }
    end
  end

  def is_shop_owner?
    if current_user
      current_user.id == @shop.owner_id
    else
      false
    end
  end

  def destroy_user_data(user_id, hash)
    case hash[:what]
    when 'all'
      Shop.where(owner_id: user_id).destroy_all
      Invite.where(user_id: user_id).destroy_all
      Invite.where(shop_owner_id: user_id).destroy_all
      User.find(user_id).destroy
    when 'invites'
      Invite.where(user_id: user_id).destroy_all
      Invite.where(shop_owner_id: user_id).destroy_all
    when 'shops'
      Shop.where(owner_id: user_id).destroy_all
      end
  end
end
