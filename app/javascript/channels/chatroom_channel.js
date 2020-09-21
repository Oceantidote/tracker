import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        if (document.getElementById('messages').dataset.user === data.match(/data-author="(\d)"/)[1]) {
          var message = data.replace('class="message', 'class="message current-user-message')
        } else {
          var message = data.replace('class="message', 'class="message other-user-message')
        }
        messagesContainer.insertAdjacentHTML('beforeend', message);
      },
    });
  }
}

export { initChatroomCable };
