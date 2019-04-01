class ChatMessage {
  ChatMessage(
      {this.id,
      this.chatRoomId,
      this.fromUserId,
      this.status,
      this.body,
      this.lockVersion,
      this.sendDatetime});

  final int id;
  final int chatRoomId;
  final int fromUserId;
  final int status;
  final String body;
  final int lockVersion;
  final DateTime sendDatetime;

  factory ChatMessage.fromJson(dynamic json) {
    if (json == null) {
      return ChatMessage();
    }
    return ChatMessage(
        id: json['id'],
        chatRoomId: json['chat_room_id'],
        fromUserId: json['from_user_id'],
        status: json['status'],
        body: json['body'],
        lockVersion: json['lock_version'],
        sendDatetime: DateTime.tryParse(json['send_datetime']));
  }

  static List<ChatMessage> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => ChatMessage.fromJson(json)).toList();
  }
}
