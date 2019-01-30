class Address {

  Address(
      {this.id,
        this.address1,
        this.address2,
        this.location,
        this.latitude,
        this.longitude,
        this.zipCode,
        this.subject});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json['id'],
        address1: json['address1'],
        address2: json['address2'],
        location: json['location'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        zipCode: json['zip_code'],
        subject: json['subject']);
  }

  static List<Address> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Address.fromJson(json)).toList();
  }


  int id;
  String address1;
  String address2;
  String location;
  double latitude;
  double longitude;
  String zipCode;
  String subject;


}
