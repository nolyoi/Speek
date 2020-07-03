class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  before_save :check_if_already_liked

  def check_if_already_liked
    like = Like.find_by(user_id: self.user_id, post_id: self.post_id)
    if like
      self.delete
      flash[:danger] = "You can only like a post once!"
    end
  end
end
