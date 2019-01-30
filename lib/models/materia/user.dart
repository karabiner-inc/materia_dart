import './address.dart';
import './organization.dart';

class User{
  User({this.id, this.name, this.role, this.iconImgUrl, this.email, this.descriptions, this.phoneNumber, this.organization, this.addresses});


  factory User.fromJson(dynamic json) {

//    print(json['organization']);
//    print(Organization.fromListJson(json['organization']));

    return User(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        iconImgUrl: json['icon_img_url'],
        email: json['email'],
        descriptions: json['descriptions'],
        phoneNumber: json['phone_number'],
//        organization: Organization.fromListJson(json['organization']),
        addresses: Address.fromListJson(json['addresses'])
    );
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

}