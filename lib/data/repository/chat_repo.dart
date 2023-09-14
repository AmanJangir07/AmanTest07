import 'package:shopiana/data/model/response/chat_model.dart';

class ChatRepo {
  List<ChatModel> getChatList() {
    List<ChatModel> chatList = [
      ChatModel('Hi, How are you?', null, DateTime.now(), false, false),
    ];
    return chatList;
  }
}
