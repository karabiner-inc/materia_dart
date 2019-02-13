class Offer {
  Offer(
      {this.id,
      this.messageSubject,
      this.offerMessage,
      this.answerMessage,
      this.status,
      this.lockVersion,
      this.projectId,
      this.fromUserId,
      this.toUserId,
      this.offerTime,
      this.answerTime});

  factory Offer.fromJson(dynamic json) {
    if (json == null) {
      return Offer();
    }
    return Offer(
        id: json['id'],
        messageSubject: json['message_subject'],
        offerMessage: json['offer_message'],
        answerMessage: json['answer_message'],
        status: json['status'],
        lockVersion: json['lock_version'],
        projectId: json['project_id'],
        fromUserId: json['from_user_id'],
        toUserId: json['to_user_id'],
        offerTime: json['offer_time'],
        answerTime: json['answer_time']);
  }

  static List<Offer> fromListJson(List<dynamic> listJson) {
    if (listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => Offer.fromJson(json)).toList();
  }

  int id;
  String messageSubject;
  String offerMessage;
  String answerMessage;
  int status;
  int lockVersion;
  int projectId;
  int fromUserId;
  int toUserId;
  String offerTime;
  String answerTime;
}
