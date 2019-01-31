class PasswordResetToken {
  PasswordResetToken({this.passwordResetToken});
  factory PasswordResetToken.fromJson(dynamic json) {
    return PasswordResetToken(
      passwordResetToken: json['password_reset_token']
    );
  }
  String passwordResetToken;

}