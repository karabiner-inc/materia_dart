import 'chat_room_member.dart';

class ChatUnread {
  ChatUnread(
      {this.id,
      this.chatMessageId,
      this.userId,
      this.isUnread,
      this.lockVersion,
      });

  final int id;
  final int chatMessageId;
  final int userId;
  final int isUnread;
  final int lockVersion;
  
  factory ChatUnread.fromJson(dynamic json) {
    if (json == null) {
      return ChatUnread();
    }
    return ChatUnread(
        id: json['id'],
        chatMessageId: json['chat_message_id'],
        userId: json['user_id'],
        isUnread: json['is_unread'],
        lockVersion: json['lock_version'],
        );
  }

  static List<ChatUnread> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => ChatUnread.fromJson(json)).toList();
  }
}
