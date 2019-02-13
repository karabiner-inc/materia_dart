import 'project.dart';
import '../materia/user.dart';

class Record {
  Record(
      {this.id,
      this.title,
      this.description,
      this.score,
      this.userId,
      this.user,
      this.projectId,
      this.project,
      this.lockVersion});

  factory Record.fromJson(dynamic json) {
    if(json == null) {
      return Record();
    }
    return Record(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        score: json['score'],
        userId: json['user_id'],
        user: User.fromJson(json['user']),
        projectId: json['project_id'],
        project: Project.fromJson(json['project']),
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
  String description;
  double score;
  int userId;
  User user;
  int projectId;
  Project project;
  int lockVersion;
}
