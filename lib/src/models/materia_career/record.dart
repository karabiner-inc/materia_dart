class Record {
  Record(
      {this.id,
      this.title,
      this.discription,
      this.userId,
      this.projectId,
      this.lockVersion});

  factory Record.fromJson(dynamic json) {
    return Record(
        id: json['id'],
        title: json['title'],
        discription: json['discription'],
        userId: json['user_id'],
        projectId: json['project_id'],
        lockVersion: json['lock_version']);
  }

  static List<Record> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Record.fromJson(json)).toList();
  }

  int id;
  String title;
  String discription;
  int userId;
  int projectId;
  int lockVersion;
}
