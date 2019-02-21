import './user.dart';

class Organization {

  Organization(
      {
        this.id,
        this.name,
        this.hpUrl,
        this.profileImgUrl,
        this.backGroundImgUrl,
        this.oneLineMessage,
        this.users,
        });

  factory Organization.fromJson(dynamic json) {
    if(json == null) {
      return Organization();
    } else if(json is List) {
      return Organization();
    }
    return Organization(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        hpUrl: json['hp_url'] ?? '',
        profileImgUrl: json['profile_img_url'] ?? '',
        backGroundImgUrl: json['back_ground_img_url'] ?? '',
        oneLineMessage: json['one_line_message'] ?? '',
        users: User.fromListJson(json['users']));
  }

  static List<Organization> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Organization.fromJson(json)).toList();
  }

  int id;
  String name;
  String hpUrl;
  String profileImgUrl;
  String backGroundImgUrl;
  String oneLineMessage;
  List<User> users;

}