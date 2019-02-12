class ProjectTag {
  ProjectTag({this.id, this.projectId, this.tagId});

  factory ProjectTag.fromJson(dynamic json) {
    return ProjectTag(
        id: json['id'], projectId: json['project_id'], tagId: json['tag_id']);
  }

  static List<ProjectTag> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => ProjectTag.fromJson(json)).toList();
  }

  int id;
  int projectId;
  int tagId;
}
