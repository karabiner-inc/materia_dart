import './user.dart';

class Organization {

  Organization(
      {this.name,
        this.hpUrl,
        this.profileImgUrl,
        this.backGroundImgUrl,
        this.oneLineMessage,
        this.users,
        });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
        name: json['name'] ?? '',
        hpUrl: json['hp_url'] ?? '',
        profileImgUrl: json['profile_img_url'] ?? '',
        backGroundImgUrl: json['back_ground_img_url'] ?? '',
        oneLineMessage: json['one_line_message'] ?? '',
        users: json['users'] == null ? [] : json['users'].map((Map<String, dynamic> user) => User.fromJson(user)));
  }

  String name;
  String hpUrl;
  String profileImgUrl;
  String backGroundImgUrl;
  String oneLineMessage;
  List<User> users;

}