import 'package:test/test.dart';
import 'package:materia_dart/materia_chat_dart.dart';

const String basePath = 'http://localhost:4001/api';
const String basePathOps = 'http://localhost:4001/api/ops';

void main() {
  Token accessToken;
  MateriaChatAPI api = MateriaChatAPI();

  String _timestamp() => (DateTime.now().millisecondsSinceEpoch + 1).toString();

  setUpAll(() async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accessToken = await api.signIn(basePath, data);
  });

  test('list chat_rooms', () async {
    List<ChatRoom> rooms =
        await api.listChatRooms(basePath, accessToken.accessToken);
    expect(rooms.isNotEmpty, true);
  });
  test('post, get, put and delete chat_rooms', () async {
    var data = {'title': 'test created'};
    final ChatRoom room =
        await api.postChatRoom(basePath, data, accessToken.accessToken);
    expect(room.title, 'test created');

    var updatedData = {'id': room.id, 'title': 'test updated'};
    final ChatRoom updatedRoom =
        await api.putChatRoom(basePath, updatedData, accessToken.accessToken);

    final ChatRoom getRoom = await api.getChatRoom(
        basePath, updatedRoom.id, accessToken.accessToken);

    expect(getRoom.title, 'test updated');

    bool isDelete =
        await api.deleteChatRoom(basePath, getRoom.id, accessToken.accessToken);

    expect(isDelete, true);
  });

  test('list chat_room_members', () async {
    List<ChatRoomMember> rooms =
        await api.listChatRoomMembers(basePath, accessToken.accessToken);
    expect(rooms.isNotEmpty, true);
  });

  test('post, get, put and delete chat_room_members', () async {
    var data = {'title': 'test created'};
    final ChatRoom room =
        await api.postChatRoom(basePath, data, accessToken.accessToken);

    var createdData = {
      'chat_room_member': {
        'chat_room_id': room.id,
        'user_id': 3,
      }
    };

    final ChatRoomMember createdRoomMember = await api.postChatRoomMember(
        basePath, createdData, accessToken.accessToken);

    var updatedData = {
      'id': createdRoomMember.id,
      'chat_room_member': {
        'user_id': 2,
        'is_admin': 1,
      }
    };

    final ChatRoomMember updatedRoomMember = await api.putChatRoomMember(
        basePath, updatedData, accessToken.accessToken);

    final ChatRoomMember getRoomMember = await api.getChatRoomMember(
        basePath, updatedRoomMember.id, accessToken.accessToken);

    expect(getRoomMember.id, createdRoomMember.id);

    bool isDelete = await api.deleteChatRoomMember(
        basePath, getRoomMember.id, accessToken.accessToken);

    expect(isDelete, true);
  });

  test('post, get, put and delete chat_messages', () async {
    var data = {'title': 'test created'};
    final ChatRoom room =
        await api.postChatRoom(basePath, data, accessToken.accessToken);

    var createdData = {
      'chat_message': {
        'chat_room_id': room.id,
        'from_user_id': 1,
        'body': 'test',
        'send_datetime': '2019-04-01 12:00:00'
      }
    };

    final ChatMessage createdChatMessage = await api.postChatMessage(
        basePath, createdData, accessToken.accessToken);

    var updatedData = {
      'id': createdChatMessage.id,
      'chat_message': {
        'chat_room_id': room.id,
        'from_user_id': 1,
        'body': 'updated test'
      }
    };

    final ChatMessage updatedChatMessage = await api.putChatMessage(
        basePath, updatedData, accessToken.accessToken);

    final ChatMessage getChatMessage = await api.getChatMessage(
        basePath, updatedChatMessage.id, accessToken.accessToken);

    expect(updatedChatMessage.body, 'updated test');

    bool isDelete = await api.deleteChatMessage(
        basePath, getChatMessage.id, accessToken.accessToken);

    expect(isDelete, true);
  });

  test('post, get, put and delete chat_unreads', () async {
    var data = {'title': 'test created'};
    final ChatRoom room =
        await api.postChatRoom(basePath, data, accessToken.accessToken);

    var createdChatData = {
      'chat_message': {
        'chat_room_id': room.id,
        'from_user_id': 1,
        'body': 'test',
        'send_datetime': '2019-04-01 12:00:00'
      }
    };

    final ChatMessage createdChatMessage = await api.postChatMessage(
        basePath, createdChatData, accessToken.accessToken);

    var createdData = {
      'chat_unread': {
        'chat_message_id': createdChatMessage.id,
        'user_id': 1,
      }
    };

    final ChatUnread createdChatUnread = await api.postChatUnread(
        basePath, createdData, accessToken.accessToken);

    var updatedData = {
      'id': createdChatUnread.id,
      'chat_unread': {
        'chat_message_id': createdChatMessage.id,
        'user_id': 1,
        'is_unread': 0,
      }
    };

    final ChatUnread updatedChatUnread =
        await api.putChatUnread(basePath, updatedData, accessToken.accessToken);

    final ChatUnread getChatUnread = await api.getChatUnread(
        basePath, updatedChatUnread.id, accessToken.accessToken);

    expect(getChatUnread.isUnread, 0);

    bool isDelete = await api.deleteChatUnread(
        basePath, getChatUnread.id, accessToken.accessToken);

    expect(isDelete, true);
  });

  test('my-chat-rooms', () async {
    List<ChatRoom> rooms =
        await api.listMyChatRooms(basePath, accessToken.accessToken);
    expect(rooms.isNotEmpty, true);
  });

  test('create-my-chat-room', () async {
    var data = {'title': 'test'};
    ChatRoom room =
        await api.createMyChatRoom(basePath, data, accessToken.accessToken);
    expect(room.title, 'test');
  });

  test('add-my-chat-room-members', () async {
    var data = {'title': 'test'};
    ChatRoom room =
        await api.createMyChatRoom(basePath, data, accessToken.accessToken);

    var addMemberData = {
      'chat_room_id': room.id,
      'members': [
        {'user_id': 2}
      ]
    };
    ChatRoom addRoom = await api.addMyChatRoomMembers(
        basePath, addMemberData, accessToken.accessToken);
    List<ChatRoomMember> users =
        addRoom.members.where((u) => u.userId == 2 && u.status != 9).toList();
    expect(users.isNotEmpty, true);
  });

  test('remove-my-chat-room-members', () async {
    var data = {'title': 'test'};
    ChatRoom room =
        await api.createMyChatRoom(basePath, data, accessToken.accessToken);

    var addMemberData = {
      'chat_room_id': room.id,
      'members': [
        {'user_id': 2}
      ]
    };
    ChatRoom addRoom = await api.addMyChatRoomMembers(
        basePath, addMemberData, accessToken.accessToken);

    var removeData = {'chat_room_id': room.id, 'members': [
        {'user_id': 2}
      ]};
    ChatRoom removeRoom = await api.removeMyChatRoomMembers(
        basePath, removeData, accessToken.accessToken);
    List<ChatRoomMember> users =
        removeRoom.members.where((u) => u.userId == 2).toList();
    expect(users[0].status, 9);
  });

  test('list-my-chat-message-recent', () async {
    var data = {'chat_room_id': 1, 'limit_count': 10};
    List<ChatMessage> msgs = await api.listMyChatMessageRecent(
        basePath, data, accessToken.accessToken);
    expect(msgs.isNotEmpty, true);
  });
}
