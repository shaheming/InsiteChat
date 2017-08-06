class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.user
    @conversation = message.conversation 
    recipient = @conversation.sender == sender ? @conversation.recipient : @conversation.sender
    broadcast_to_sender(sender,recipient,message)
    broadcast_to_recipient(sender,recipient,message)
  end

  private

  def broadcast_to_sender(sender,recipient, message)
    
    ActionCable.server.broadcast(
      "conversations-#{sender.id}",
      message: render_message(message, sender),
      # friend_list:render_friend_list(message,recipient),
      conversation_id: message.conversation_id
    )
    
  end

  def broadcast_to_recipient(sender,recipient, message)

    ActionCable.server.broadcast(
      "conversations-#{recipient.id}",
      message: render_message(message,recipient),
        #friend_list:render_friend_list(message,recipient),
     sender_id: sender.id,
     unread_num: recipient.unread(recipient,sender),
     conversation_id: message.conversation_id,
     friend_list: render_friend_list(sender,recipient)
    )
  end
 
  def render_friend_list(sender,recipient)

    if recipient.add_friend(sender)
     ApplicationController.render(
      partial: 'friends/friend',
      locals: { user: recipient, friend:sender  }
    ) 
   end
  end 

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end
end
