import '../materia/organization.dart';

class Project {
  Project(
      {this.id,
      this.title,
      this.thumbnailImgUrl,
      this.backGroundImgUrl,
      this.overview,
      this.description,
      this.organizationId,
      this.organization,
      this.projectCategory,
      this.projectStartDate,
      this.projectEndDate,
      this.workStartDate,
      this.workEndDate,
      this.status,
      this.pay,
      this.workStyle,
      this.location,
      this.lockVersion});

  factory Project.fromJson(dynamic json) {
    if(json == null) {
      return Project();
    }
    return Project(
        id: json['id'],
        title: json['title'],
        thumbnailImgUrl: json['thumbnail_img_url'],
        backGroundImgUrl: json['back_ground_img_url'],
        overview: json['overview'],
        description: json['description'],
        organizationId: json['organization_id'],
        organization: Organization.fromJson(json['organization']),
        projectCategory: json['project_category'],
        projectStartDate: DateTime.tryParse(json['project_start_date'] ?? ''),
        projectEndDate: DateTime.tryParse(json['project_end_date'] ?? ''),
        workStartDate: DateTime.tryParse(json['work_start_date'] ?? ''),
        workEndDate: DateTime.tryParse(json['work_end_date'] ?? ''),
        status: json['status'],
        pay: json['pay'],
        workStyle: json['work_style'],
        location: json['location'],
        lockVersion: json['lock_version']);
  }

  static List<Project> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Project.fromJson(json)).toList();
  }

  int id;
  String title;
  String thumbnailImgUrl;
  String backGroundImgUrl;
  String overview;
  String description;
  int organizationId;
  Organization organization;
  String projectCategory;
  DateTime projectStartDate;
  DateTime projectEndDate;
  DateTime workStartDate;
  DateTime workEndDate;
  int status;
  int pay;
  String workStyle;
  String location;
  int lockVersion;
}
