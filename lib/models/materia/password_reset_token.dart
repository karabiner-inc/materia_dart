class PasswordResetToken {
  PasswordResetToken({this.passwordResetToken});
  factory PasswordResetToken.fromJson(Map<String, dynamic> json) {
    return PasswordResetToken(
      passwordResetToken: json['password_reset_token']
    );
  }
  String passwordResetToken;

}