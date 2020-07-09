class Private::Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  private

  def create_participants
    conversation = Conversation.create
  end

end
