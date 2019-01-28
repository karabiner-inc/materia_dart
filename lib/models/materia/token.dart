class Token {

  Token({this.id, this.accessToken, this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  int id;
  String accessToken;
  String refreshToken;

}