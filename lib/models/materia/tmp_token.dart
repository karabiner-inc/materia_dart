import './user.dart';

class TmpToken {
  TmpToken({this.userRegistrationToken, this.user});
  factory TmpToken.fromJson(dynamic json) {
    return TmpToken(
      userRegistrationToken: json['user_registration_token'],
      user: User.fromJson(json['user'])
    );
  }

  String userRegistrationToken;
  User user;

}