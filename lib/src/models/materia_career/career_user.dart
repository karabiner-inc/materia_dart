import '../materia/address.dart';
import '../materia/organization.dart';
import 'skill.dart';

class CareerUser{
  CareerUser({this.id, this.name, this.role, this.iconImgUrl, this.email, this.descriptions, this.phoneNumber, this.organization, this.addresses, this.skills});


  factory CareerUser.fromJson(dynamic json) {
    if (json == null) {
      return CareerUser();
    }
    return CareerUser(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        iconImgUrl: json['icon_img_url'],
        email: json['email'],
        descriptions: json['descriptions'],
        phoneNumber: json['phone_number'],
        organization: Organization.fromJson(json['organization']),
        addresses: Address.fromListJson(json['addresses']),
        skills: Skill.fromListJson(json['skills'])
    );
  }

  static List<CareerUser> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => CareerUser.fromJson(json)).toList();
  }

  int id;
  String name;
  String role;
  String iconImgUrl;
  String email;
  String descriptions;
  String phoneNumber;
  List<Address> addresses;
  Organization organization;
  List<Skill> skills;
}