// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' as math;
import 'dart:js';

// import 'package:materia_dart/phoenixjs.dart';
import 'package:materia_dart/phoenixjs.dart';
import 'package:materia_dart/materia_chat_dart.dart';

String basePath = 'http://localhost:4001/api';

void main() async {

  MateriaChatAPI api = MateriaChatAPI();
  
  // sign in
  Token token = await api.signIn(basePath,
      {'email': 'hogehoge@example.com', 'password': 'hogehoge'});

  // Get recent messages.
  List<ChatMessage> msgs = await api.listMyChatMessageRecent(basePath, {'chat_room_id': 1, 'limit_count': 20}, token.accessToken);
  msgs.forEach((m) => querySelector('#messages').appendHtml('<li>${m.body}</li>'));

  // Connect websocket
  var tokenOpt = TokenOption(access_token: token.accessToken);
  var opt = SocketConnectOption(params: tokenOpt);
  var socket = Socket('ws://localhost:4001/room-chat-socket', opt);

  socket.connect();
  var channel = socket.channel('room:1', opt);

  channel.join().receive('ok', allowInterop(([dynamic a]) {
    print('connection success!');
  })).receive('error', allowInterop(([dynamic a]) {
    print('connection failed!');
  }));

  channel.on('msg', allowInterop(([PayloadResponse payload]) {
    querySelector('#messages').appendHtml('<li>${payload.body}</li>');
  }));

  querySelector('#send').addEventListener('click', (Event e) {
    var text = (querySelector('.text') as InputElement).value;
    var msg = Payload(body: text);
    channel.push('msg', msg);
  });
}
