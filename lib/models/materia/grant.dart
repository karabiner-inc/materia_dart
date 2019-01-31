class Grant {

  Grant({this.id, this.role, this.method, this.requestPath});

  factory Grant.fromJson(dynamic json) {
    return Grant(
      id: json['id'],
      role: json['role'],
      method: json['method'],
      requestPath: json['request_path']
    );
  }

  static List<Grant> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Grant.fromJson(json)).toList();
  }

  int id;
  String role;
  String method;
  String requestPath;
}