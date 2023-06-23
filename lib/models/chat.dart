// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ChatMessageType { user, bot }

class Chat {
  Chat({required this.text, required this.chatType});
  String text;
  ChatMessageType chatType;
}
