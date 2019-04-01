import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'materia_api.dart';

import '../models/materia_chat/chat_room.dart';
import '../models/materia_chat/chat_room_member.dart';
import '../models/materia_chat/chat_unread.dart';
import '../models/materia_chat/chat_message.dart';


class MateriaChatAPI extends MateriaAPI {
  // chat_rooms
  Future<List<ChatRoom>> listChatRooms(String basePath, String token) async {
    final String path = p.join(basePath, 'chat_rooms');
    final http.Response response = await get(path, token: token);
    return ChatRoom.fromListJson(json.decode(response.body));
  }

  Future<ChatRoom> getChatRoom(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_rooms/$id');
    final http.Response response = await get(path, token: token);
    return ChatRoom.fromJson(json.decode(response.body));
  }

  Future<ChatRoom> postChatRoom(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_rooms');
    final http.Response response = await post(path, data, token: token);
    return ChatRoom.fromJson(json.decode(response.body));
  }

  Future<ChatRoom> putChatRoom(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_rooms/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return ChatRoom.fromJson(json.decode(response.body));
  }

  Future<bool> deleteChatRoom(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_rooms/$id');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  // chat_room_members
  Future<List<ChatRoomMember>> listChatRoomMembers(
      String basePath, String token) async {
    final String path = p.join(basePath, 'chat_room_members');
    final http.Response response = await get(path, token: token);
    return ChatRoomMember.fromListJson(json.decode(response.body));
  }

  Future<ChatRoomMember> getChatRoomMember(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_room_members/$id');
    final http.Response response = await get(path, token: token);
    return ChatRoomMember.fromJson(json.decode(response.body));
  }

  Future<ChatRoomMember> postChatRoomMember(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_room_members');
    final http.Response response = await post(path, data, token: token);
    return ChatRoomMember.fromJson(json.decode(response.body));
  }

  Future<ChatRoomMember> putChatRoomMember(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_room_members/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return ChatRoomMember.fromJson(json.decode(response.body));
  }

  Future<bool> deleteChatRoomMember(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_room_members/$id');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  // chat_messages
  Future<List<ChatMessage>> listChatMessages(
      String basePath, String token) async {
    final String path = p.join(basePath, 'chat_messages');
    final http.Response response = await get(path, token: token);
    return ChatMessage.fromListJson(json.decode(response.body));
  }

  Future<ChatMessage> getChatMessage(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_messages/$id');
    final http.Response response = await get(path, token: token);
    return ChatMessage.fromJson(json.decode(response.body));
  }

  Future<ChatMessage> postChatMessage(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_messages');
    final http.Response response = await post(path, data, token: token);
    return ChatMessage.fromJson(json.decode(response.body));
  }

  Future<ChatMessage> putChatMessage(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_messages/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return ChatMessage.fromJson(json.decode(response.body));
  }

  Future<bool> deleteChatMessage(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_messages/$id');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  // chat_unreads
  Future<List<ChatUnread>> listChatUnreads(String basePath, String token) async {
    final String path = p.join(basePath, 'chat_unreads');
    final http.Response response = await get(path, token: token);
    return ChatUnread.fromListJson(json.decode(response.body));
  }

  Future<ChatUnread> getChatUnread(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_unreads/$id');
    final http.Response response = await get(path, token: token);
    return ChatUnread.fromJson(json.decode(response.body));
  }

  Future<ChatUnread> postChatUnread(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_unreads');
    final http.Response response = await post(path, data, token: token);
    return ChatUnread.fromJson(json.decode(response.body));
  }

  Future<ChatUnread> putChatUnread(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'chat_unreads/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return ChatUnread.fromJson(json.decode(response.body));
  }

  Future<bool> deleteChatUnread(
      String basePath, int id, String token) async {
    final String path = p.join(basePath, 'chat_unreads/$id');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  // my-chat-rooms
  Future<List<ChatRoom>> listMyChatRooms(String basePath, String token) async {
    final String path = p.join(basePath, 'my-chat-rooms');
    final http.Response response = await get(path, token: token);
    return ChatRoom.fromListJson(json.decode(response.body));
  }

  // create-my-chat-room
  Future<ChatRoom> createMyChatRoom(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-chat-room');
    final http.Response response = await post(path, data, token: token);
    return ChatRoom.fromJson(json.decode(response.body));
  }

  // add-my-chat-room-members
  Future<ChatRoom> addMyChatRoomMembers(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'add-my-chat-room-members');
    final http.Response response = await post(path, data, token: token);
    return ChatRoom.fromJson(json.decode(response.body));
  }

  // remove-my-chat-room-members
  Future<ChatRoom> removeMyChatRoomMembers(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'remove-my-chat-room-members');
    final http.Response response = await post(path, data, token: token);
    return ChatRoom.fromJson(json.decode(response.body));
  }

  // list-my-chat-message-recent
  Future<List<ChatMessage>> listMyChatMessageRecent(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'list-my-chat-message-recent');
    final http.Response response = await post(path, data, token: token);
    return ChatMessage.fromListJson(json.decode(response.body));
  }
}
