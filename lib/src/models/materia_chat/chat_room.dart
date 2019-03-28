import 'chat_room_member.dart';

class ChatRoom {
  ChatRoom(
      {this.id,
      this.title,
      this.accessPoricy,
      this.status,
      this.lockVersion,
      this.members,
      });

  final int id;
  final String title;
  final String accessPoricy;
  final int status;
  final int lockVersion;
  final List<ChatRoomMember> members;
  
  factory ChatRoom.fromJson(dynamic json) {
    if (json == null) {
      return ChatRoom();
    }
    return ChatRoom(
        id: json['id'],
        title: json['title'],
        accessPoricy: json['access_poricy'],
        status: json['status'],
        lockVersion: json['lock_version'],
        members: ChatRoomMember.fromListJson(json['members'])
        );
  }

  static List<ChatRoom> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => ChatRoom.fromJson(json)).toList();
  }
}
