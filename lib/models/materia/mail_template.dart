class MailTemplate {

  MailTemplate({this.id, this.body, this.lockVersion, this.status, this.subject, this.mailTemplateType});

  factory MailTemplate.fromJson(dynamic json) {
    return MailTemplate(
      id: json['id'],
      body: json['body'],
      lockVersion: json['lock_version'],
      status: json['status'],
      subject: json['subject'],
      mailTemplateType: json['mail_template_type']
    );
  }

  static List<MailTemplate> fromListJson(List<dynamic> listJson) {
    if(listJson.isEmpty) {
      return [];
    }
    return listJson.map((dynamic json) => MailTemplate.fromJson(json)).toList();
  }

  int id;
  String body;
  int lockVersion;
  int status;
  String subject;
  String mailTemplateType;

}