import './address.dart';

class User{
  User({this.id, this.name, this.role, this.iconImgUrl, this.email, this.addresses});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        iconImgUrl: json['icon_img_url'],
        email: json['email'],
        addresses: json['addresses'].isEmpty ? [] : json['addresses'].map((Map<String, dynamic> address)=>Address.fromJson(address)).toList()
    );
  }

  int id;
  String name;
  String role;
  String iconImgUrl;
  String email;
  List<Address> addresses;

}