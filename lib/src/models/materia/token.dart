import 'user.dart';

class Token {
  Token(
      {this.id,
      this.accessToken,
      this.refreshToken,
      this.userRegistrationToken,
      this.passwordResetToken,
      this.user});

  factory Token.fromJson(dynamic json) {
    return Token(
      id: json['id'] ?? null,
      accessToken: json['access_token'] != null ? json['access_token']: null,
      refreshToken: json['refresh_token'] != null ? json['refresh_token'] :null,
      userRegistrationToken: json['user_registration_token'] != null ? json['user_registration_token'] : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      passwordResetToken: json['password_reset_token'] != null ? json['password_reset_token'] : null
    );
  }

  int id;
  String accessToken;
  String refreshToken;
  String userRegistrationToken;
  User user;
  String passwordResetToken;
}
