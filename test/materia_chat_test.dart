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

  test('connection websocket', () async {
    // final PhoenixSocket socket = PhoenixSocket('ws://localhost:4000/room-chat-socket');
    // await socket.connect();
    // var chatChannel = socket.channel('room:1', {'access_token': accessToken});

    // chatChannel.on("user_entered", PhoenixMessageCallback(Map payload, String _ref, String, _joinRef) {
    //     print(payload);
    // });
    // chatChannel.join();
  });

}
