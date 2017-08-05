class MessagesController < ApplicationController
  before_action do
    authenticate_user!
    @conversation = Conversation.find(params[:conversation_id])

  end
  def index
    @messages = Conversation.find(params[:conversation_id]).messages
    @messages.update_all(is_read: true)
  end
  def create
    @message = @conversation.messages.new(:content=>params[:message][:content],:user_id=>current_user.id)

    if @message.save
      redirect_to :back
    end
  end
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to :back
  end

end
