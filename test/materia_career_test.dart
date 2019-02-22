import 'package:test/test.dart';
import 'package:materia_dart/materia_career_dart.dart';

const String basePath = 'http://localhost:4001/api';
const String basePathOps = 'http://localhost:4001/api/ops';

void main() {
  Token accessToken;
  MateriaCareerAPI api = MateriaCareerAPI();

  String _timestamp() => (DateTime.now().millisecondsSinceEpoch + 1).toString();

  setUpAll(() async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accessToken = await api.signIn(basePath, data);
  });

  test('list projects', () async {
    final List<Project> projects = await api.listProjects(basePath);
    expect(projects.isNotEmpty, true);
  });

  test('list my projects', () async {
    var data = {
      'status_list': [1, 2]
    };
    final List<Project> projects =
        await api.listMyProjects(basePath, data, accessToken.accessToken);
    expect(projects.isNotEmpty, true);
  });

  test('create and update my projects', () async {
    var data = {'title': 'project1'};
    final Project projects =
        await api.createMyProject(basePath, data, accessToken.accessToken);
    expect(projects.title, 'project1');
    var updateData = {'id': projects.id, 'title': 'project2'};
    final Project updatedProjects = await api.updateMyProject(
        basePath, updateData, accessToken.accessToken);
    expect(updatedProjects.title, 'project2');
  });

  test('list my offers', () async {
    var data = {'status': '1'};
    final List<Offer> offers =
        await api.listMyOffers(basePath, data, accessToken.accessToken);
    expect(offers.isNotEmpty, true);
  });

  test('list-my-projects-offers', () async {
    var data = {
      'status': '1',
      'project_id_list': [1]
    };
    final List<Offer> offers =
        await api.listMyProjectsOffers(basePath, data, accessToken.accessToken);
    expect(offers.isEmpty, true);
  });

  test('create-my-organization-offer', () async {
    var data = {'title': 'project1', 'status': 2};
    final Project projects =
        await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOrganizationOffer(
        basePath, createOfferData, accessToken.accessToken);
    expect(offers.offerMessage, 'test offer');
  });

  test('create-my-offer', () async {
    var data = {'title': 'project1', 'status': 2};
    final Project projects =
        await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOffer(
        basePath, createOfferData, accessToken.accessToken);
    expect(offers.offerMessage, 'test offer');
  });

  test('update-my-organization-offer', () async {
    var data = {'title': 'project1', 'status': 2};
    final Project projects =
        await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOrganizationOffer(
        basePath, createOfferData, accessToken.accessToken);

    var updateOfferData = {
      'offer_id': offers.id,
      'project_id': projects.id,
      'offer_message': 'updated test offer',
      'message_subject': 'updated test',
      'status': 2
    };

    final Offer updatedOffer = await api.updateMyOrganizationOffer(
        basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.offerMessage, 'updated test offer');
  });

  test('update-my-offer', () async {
    var data = {'title': 'project1', 'status': 2};
    final Project projects =
        await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOffer(
        basePath, createOfferData, accessToken.accessToken);

    var updateOfferData = {
      'offer_id': offers.id,
      'project_id': projects.id,
      'offer_message': 'updated test offer',
      'message_subject': 'updated test',
      'status': 2
    };

    final Offer updatedOffer = await api.updateMyOffer(
        basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.offerMessage, 'updated test offer');
  });

  test('update-my-organization-offer', () async {
    var data = {'title': 'project1', 'status': 2};
    final Project projects =
        await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOrganizationOffer(
        basePath, createOfferData, accessToken.accessToken);

    var updateOfferData = {
      'offer_id': offers.id,
      'answer_message': 'answer message',
      'status': 2,
      'lock_version': offers.lockVersion,
    };

    final Offer updatedOffer = await api.answerOfferToMyOrganization(
        basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.answerMessage, 'answer message');
  });

//  test('answer-offer-to-me', () async {
//    var data = {'status': '1'};
//    final List<Offer> offers = await api.listMyOffers(basePath, data, accessToken.accessToken);
//
//    var updateOfferData = {
//      'offer_id': offers[0].id,
//      'answer_message': 'answer message',
//      'status': 1,
//      'lock_version': offers[0].lockVersion,
//    };
//
//    final Offer updatedOffer = await api.answerOfferToMe(basePath, updateOfferData, accessToken.accessToken);
//    expect(updatedOffer.answerMessage, 'answer message');
//
//  });

//  records

  test('list-my-records', () async {
    final List<Record> records =
        await api.listMyRecords(basePath, accessToken.accessToken);
    expect(records.isNotEmpty, true);
  });

  test('create-my-record', () async {
    var data = {
      'title': 'title1',
      'description': 'description1',
      'score': 10.0,
      'project_id': 1
    };
    final Record record =
        await api.createMyRecord(basePath, data, accessToken.accessToken);
    expect(record.title, 'title1');
    expect(record.score, 10.0);
  });

  test('update-my-record', () async {
    var data = {
      'title': 'title1',
      'description': 'description1',
      'score': 10.0,
      'project_id': 1
    };
    final Record record =
        await api.createMyRecord(basePath, data, accessToken.accessToken);

    var updateData = {
      'id': record.id,
      'title': 'updated title1',
      'description': 'updated description1',
      'score': 12.0,
      'project_id': 1
    };
    final Record updatedRecord =
        await api.updateMyRecord(basePath, updateData, accessToken.accessToken);
    expect(updatedRecord.title, 'updated title1');
    expect(updatedRecord.score, 12.0);
  });

  // skills
  test('create-my-skill and list-my-skills and list-user-skills', () async {
    var data = {
      'subject': 'subject1',
      'name': 'name1',
      'start_date': '2010-01-01',
      'end_date': '2010-01-01',
    };
    final Skill skill =
        await api.createMySkill(basePath, data, accessToken.accessToken);
    expect(skill.subject, 'subject1');
    expect(skill.name, 'name1');

    final List<Skill> skills =
        await api.listMySkills(basePath, accessToken.accessToken);
    expect(skills.isNotEmpty, true);
    
    final List<Skill> userSkills =
        await api.listUserSkills(basePath, skill.userId, accessToken.accessToken);
    expect(userSkills.isNotEmpty, true);
  });

//  test('create-my-skills and list-my-skills', () async {
//    var data = {
//      'skills': [
//        {
//          'subject': 'subject1',
//          'name': 'name1',
//          'start_date': '2010-01-01',
//          'end_date': '2010-01-01',
//        },
//        {
//          'subject': 'subject1',
//          'name': 'name1',
//          'start_date': '2010-01-01',
//          'end_date': '2010-01-01',
//        }
//      ],
//      'is_delete': true
//    };
//    final List<Skill> createSkills =
//        await api.createMySkills(basePath, data, accessToken.accessToken);
//    expect(createSkills.length, 2);
//
//    final List<Skill> skills =
//        await api.listMySkills(basePath, accessToken.accessToken);
//    expect(skills.length, 2);
//  });

  test('update-my-record', () async {
    var data = {
      'subject': 'subject1',
      'name': 'name1',
      'start_date': '2010-01-01',
      'end_date': '2010-01-01',
    };
    final Skill skill =
        await api.createMySkill(basePath, data, accessToken.accessToken);
    expect(skill.subject, 'subject1');

    var updateData = {
      'id': skill.id,
      'subject': 'subject2',
      'name': 'name2',
      'start_date': '2010-01-01',
      'end_date': '2010-01-01',
    };
    final Skill updatedSkill =
        await api.updateMySkill(basePath, updateData, accessToken.accessToken);
    expect(updatedSkill.subject, 'subject2');
    expect(updatedSkill.name, 'name2');
  });

  test('delete-my-record', () async {
    var data = {
      'subject': 'subject1',
      'name': 'name1',
      'start_date': '2010-01-01',
      'end_date': '2010-01-01',
    };
    final Skill skill =
        await api.createMySkill(basePath, data, accessToken.accessToken);
    expect(skill.subject, 'subject1');

    var deleteData = {
      'id': skill.id,
    };
    final bool result =
        await api.deleteMySkill(basePath, deleteData, accessToken.accessToken);
    expect(result, true);
  });


  // skills
  test('user with skill api', () async {
    var data = {
      'subject': 'subject1',
      'name': 'name1',
      'start_date': '2010-01-01',
      'end_date': '2010-01-01',
    };
    final Skill skill =
    await api.createMySkill(basePath, data, accessToken.accessToken);
    expect(skill.subject, 'subject1');
    expect(skill.name, 'name1');
    expect(skill.userId, 1);

    final List<CareerUser> users1 =
    await api.listUsersWithSkills(basePath, accessToken.accessToken);
    expect(users1.isNotEmpty, true);

    final List<CareerUser> users2 =
    await api.listUsersWithSkillsByStatus(basePath, 9 , accessToken.accessToken);
    expect(users2.isEmpty, true);

    final CareerUser user1 =
    await api.showMeWithSkills(basePath, accessToken.accessToken);
    expect(user1.skills.isNotEmpty, true);

    final CareerUser user2 =
    await api.getUserWithSkills(basePath, skill.userId, accessToken.accessToken);
    expect(user2.skills.isNotEmpty, true);
  });

}
