import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        const lastMessage = messagesContainer.children[messagesContainer.children.length - 1]
        // First if determines who the author is and what class it should get
        if (messagesContainer.dataset.user === data.match(/data-author="(\d)"/)[1]) {
          var data = data.replace('class="message', 'class="message current-user-message')
        } else {
          var data = data.replace('class="message', 'class="message other-user-message')
        }
        console.log(data)
        messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initChatroomCable };

// This code works fine but not sure if we want the functionality or not so just saving it incase we need it.

// if (messagesContainer.dataset.user === data.match(/data-author="(\d)"/)[1]) {
//   // Nested if's determine who sent the last message in order to only show author info once per message block
//   if (lastMessage.classList.contains('other-user-message')) {
//   } else {
//     var data = data.replace(/<i>.*<\/i>/, '').replace(/<div class="avatar-sm.*\n.*\n.*>/, '<div class="avatar-sm"></div>')
//   }
//   var data = data.replace('class="message', 'class="message current-user-message')
// } else {
//   if (lastMessage.classList.contains('other-user-message')) {
//     var data = data.replace(/<i>.*<\/i>/, '').replace(/<div class="avatar-sm.*\n.*\n.*>/, '<div class="avatar-sm"></div>')
//   }
//   var data = data.replace('class="message', 'class="message other-user-message')
// }
