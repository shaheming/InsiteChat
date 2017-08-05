require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @sender= User.create!(username: "Sender",email:"sender@example.com",
                      password: "123456",password_confirmation:"123456")
    @recipient= User.create!(username: "Recipient",email:"recipient@example.com",
                         password: "123456",password_confirmation:"123456")
  end

  test "Create a conversation" do
    
    post conversation_path,params:{:sender_id=>@sender.id,:recipient_id=> @recipient.id}
    
    @conversation = Conversation.first
    assert_not_nil  @conversation
    assert_equal  @conversation.sender_id , @sender.id
    assert_equal  @conversation.recipient_id , @recipient.id
  end

end
