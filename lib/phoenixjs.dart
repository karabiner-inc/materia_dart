@JS()
library lib;

import 'package:js/js.dart';
import 'src/func.dart';

@JS()
external num addNumbers(num a, num b);

void add1And2() {
  print(addNumbers(1, 2));
}

@JS()
class Animal {
  external factory Animal(String name);
  external String talk();
}

@JS()
class Push {
  // @Ignore
  Push.fakeConstructor$();
  external factory Push(
      dynamic channel, String event, dynamic payload, num timeout);
  external void send();
  external void resend(num timeout);
  external Push receive(String status, Function callback([dynamic response]));
}

@anonymous
@JS()
class Payload {
  external set body(String token);
  external String get body;
  external factory Payload({
    String body,
  });
}

@anonymous
@JS()
class PayloadResponse {
  external set id(int id);
  external int get id;
  external set from_user_id(int userId);
  external int get from_user_id;
  external set body(String token);
  external String get body;
  external set send_datetime(String date);
  external String get send_datetime;
  external factory PayloadResponse({
    int id,
    int from_user_id,
    String body,
    String send_datetime,
  });
}

@JS()
class Channel {
  // @Ignore
  Channel.fakeConstructor$();
  external factory Channel(String topic,
      [dynamic /*object|Function*/ params, Socket socket]);
  external Push join([num timeout]);
  external Push leave([num timeout]);
  external void onClose(Function callback);
  external void onError(void callback([dynamic reason]));
  external dynamic onMessage(String event, dynamic payload, dynamic ref);
  external void on(String event, Function callback([PayloadResponse response]));
  external void off(String event);
  external Push push(String event, Payload payload, [num timeout]);
}

@anonymous
@JS()
class TokenOption {
  external set access_token(String token);
  external String get access_token;
  external factory TokenOption({
    String access_token,
  });
}

@anonymous
@JS()
abstract class SocketConnectOption {
  external dynamic /*object|Function*/ get params;
  external set params(dynamic /*object|Function*/ v);
  external dynamic get transport;
  external set transport(dynamic v);
  external num get timeout;
  external set timeout(num v);
  external num get heartbeatIntervalMs;
  external set heartbeatIntervalMs(num v);
  external num get reconnectAfterMs;
  external set reconnectAfterMs(num v);
  external num get longpollernumber;
  external set longpollernumber(num v);
  external Func2<dynamic, Function, dynamic> get encode;
  external set encode(Func2<dynamic, Function, dynamic> v);
  external Func2<String, Function, dynamic> get decode;
  external set decode(Func2<String, Function, dynamic> v);
  external VoidFunc3<String, String, dynamic> get logger;
  external set logger(VoidFunc3<String, String, dynamic> v);
  external factory SocketConnectOption(
      {dynamic /*object|Function*/ params,
      dynamic transport,
      num timeout,
      num heartbeatIntervalMs,
      num reconnectAfterMs,
      num longpollernumber,
      Func2<dynamic, Function, dynamic> encode,
      Func2<String, Function, dynamic> decode,
      VoidFunc3<String, String, dynamic> logger});
}

@JS()
class Socket {
  // @Ignore
  Socket.fakeConstructor$();
  external factory Socket(String endPoint, [SocketConnectOption opts]);
  external String protocol();
  external String endPointURL();
  external void connect([dynamic params]);
  external void disconnect([Function callback, num code, String reason]);
  external String /*'connecting'|'open'|'closing'|'closed'*/ connectionState();
  external bool isConnected();
  external void remove(Channel channel);
  external Channel channel(String topic, [dynamic chanParams]);
  external void push(dynamic data);
  external void log(String kind, String message, dynamic data);
  external bool hasLogger();
  external void onOpen(Function callback);
  external void onClose(Function callback);
  external void onError(Function callback);
  external void onMessage(Function callback);
  external String makeRef();
}
