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

  int id;
  String role;
  String method;
  String requestPath;
}