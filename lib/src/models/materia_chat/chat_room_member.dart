import '../materia/user.dart';

class ChatRoomMember {
  ChatRoomMember(
      {this.id,
      this.chatRoomId,
      this.userId,
      this.status,
      this.isAdmin,
      this.lockVersion,
      this.user});

  final int id;
  final int chatRoomId;
  final int userId;
  final int isAdmin;
  final int status;
  final int lockVersion;
  final User user;

  factory ChatRoomMember.fromJson(dynamic json) {

    if (json == null) {
      return ChatRoomMember();
    }
    return ChatRoomMember(
        id: json['id'],
        chatRoomId: json['chat_room_id'],
        userId: json['user_id'],
        status: json['status'],
        isAdmin: json['is_admin'],
        lockVersion: json['lock_version'],
        user: json['user'] is List ? User() : User.fromJson(json['user']) // TODO: 本当はMAPで来るはず
        );
  }

  static List<ChatRoomMember> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => ChatRoomMember.fromJson(json)).toList();
  }
}
