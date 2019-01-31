import './organization.dart';
import './user.dart';

class Account {

  Account({
    this.id,
    this.name,
    this.externalCode,
    this.startDatetime,
    this.frozenDatetime,
    this.expiredDatetime,
    this.descriptions,
    this.status,
    this.lockVersion,
    this.mainUser,
    this.organization
  });

  factory Account.fromJson(dynamic json) {
    return Account(
      id: json['id'],
      name: json['name'],
      externalCode: json['external_code'],
      startDatetime: json['start_datetime'],
      frozenDatetime: json['frozen_datetime'],
      expiredDatetime: json['expired_datetime'],
      descriptions: json['descriptions'],
      status: json['status'],
      lockVersion: json['lock_version'],
      mainUser: User.fromJson(json['main_user']),
      organization: Organization.fromJson(json['organization']),

    );
  }

  static List<Account> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Account.fromJson(json)).toList();
  }

  int id;
  String name;
  String externalCode;
  String startDatetime;
  String frozenDatetime;
  String expiredDatetime;
  String descriptions;
  int status;
  int lockVersion;
  User mainUser;
  Organization organization;


}