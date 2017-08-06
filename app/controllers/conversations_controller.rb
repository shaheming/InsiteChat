class ConversationsController < ApplicationController
  def create
    # debugger
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

     recipient = User.find(params[:recipient_id])
     if !current_user.friends.include?(recipient)
       friendship = recipient.friend_ships.new(:friend_id => current_user.id)
       friendship.save 
     end

     redirect_to conversation_messages_path(@conversation)

  end
  private
  def conversation_params
    params.permit(:sender_id,:recipient_id)
  end
end
