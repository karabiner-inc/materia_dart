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

  factory Organization.fromJson(dynamic json) {
    if(json == null) {
      return Organization();
    }
    return Organization(
        name: json['name'] ?? '',
        hpUrl: json['hp_url'] ?? '',
        profileImgUrl: json['profile_img_url'] ?? '',
        backGroundImgUrl: json['back_ground_img_url'] ?? '',
        oneLineMessage: json['one_line_message'] ?? '',
        users: json['users'] == null ? [] : json['users'].map((dynamic user) => User.fromJson(user)));
  }

  static List<Organization> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Organization.fromJson(json)).toList();
  }

  String name;
  String hpUrl;
  String profileImgUrl;
  String backGroundImgUrl;
  String oneLineMessage;
  List<User> users;

}