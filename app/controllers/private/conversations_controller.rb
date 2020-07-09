class Private::ConversationsController < ApplicationController

  def index
    @conversations = Private::Conversation.all
  end

  def show
    @conversation = Private::Conversation.find(params[:id])
  end
  
  
end
