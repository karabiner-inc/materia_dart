class Tag {
  Tag({this.id, this.label});
  factory Tag.fromJson(dynamic json) =>
      Tag(id: json['id'], label: json['label']);
  static List<Tag> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Tag.fromJson(json)).toList();
  }

  int id;
  String label;
}
