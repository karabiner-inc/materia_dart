class ResponseAuth {
  ResponseAuth({this.message});
  String message;

  factory ResponseAuth.fromJson(dynamic json) =>
      ResponseAuth(message: json['message']);
}
