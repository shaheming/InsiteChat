//= require cable
//= require_self
//= require_tree .
App.conversation = App.cable.subscriptions.create("ConversationChannel", {

  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var conversation = $('#chat-body').find('ul').append(data['message']);
    var friend_list = $('#friend-list').append(data['friend_list']);
    var chat = $('.panel-body');
    var friend_item = $('#friend-'+data['sender_id']).find('.unread').text(data['unread_num'])
    chat.scrollTop(chat.prop("scrollHeight"));
    console.log('get-something');
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});
$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});