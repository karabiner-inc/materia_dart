class Skill {
  Skill({this.id, this.name, this.subject, this.startDate, this.endDate, this.userId});
  String subject;
  String name;
  DateTime startDate;
  DateTime endDate;
  int userId;
  int id;

  factory Skill.fromJson(dynamic json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      startDate: json['start_date'] != null ? DateTime.tryParse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.tryParse(json['end_date']) : null
    );
  }

  static List<Skill> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Skill.fromJson(json)).toList();
  }

}