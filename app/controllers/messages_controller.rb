class MessagesController < ApplicationController
  before_action do
    authenticate_user!
    @conversation = Conversation.find(params[:conversation_id])

  end
  def index
    @messages = Conversation.find(params[:conversation_id]).messages
    sender  = @conversation.sender == current_user ? @conversation.recipient :  @conversation.sender
    if current_user.unread(current_user,sender)
      messages = @conversation.messages.where('user_id = ?  and is_read = ?',sender.id,false)
      messages.each do |message|
        if message.user_id != @conversation.sender.id
          message.update_attribute(:is_read, 'true')
        end
      end
    end
  end

  def create
    @message = @conversation.messages.new(:content=>params[:message][:content],:user_id=>current_user.id)
    @message.save
  end
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
  end

end
