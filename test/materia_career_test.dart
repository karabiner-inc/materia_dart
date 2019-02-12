import 'package:test/test.dart';
import 'package:materia_dart/materia_career_dart.dart';
import 'package:materia_dart/materia_dart.dart';

const String basePath='http://localhost:4001/api';
const String basePathOps='http://localhost:4001/api/ops';

void main() {

  Token accessToken;
  MateriaCareerAPI api = MateriaCareerAPI();

  String _timestamp() => (DateTime.now().millisecondsSinceEpoch + 1).toString();

  setUpAll(() async{
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
    var data = {'status_list': [1,2]};
    final List<Project> projects = await api.listMyProjects(basePath, data, accessToken.accessToken);
    expect(projects.isNotEmpty, true);
  });

  test('create and update my projects', () async {
    var data = {'title': 'project1'};
    final Project projects = await api.createMyProject(basePath, data, accessToken.accessToken);
    expect(projects.title, 'project1');
    var updateData = {
      'id': projects.id,
      'title': 'project2'
    };
    final Project updatedProjects = await api.updateMyProject(basePath, updateData, accessToken.accessToken);
    expect(updatedProjects.title, 'project2');
  });

  test('list my offers', () async {
    var data = {'status': '1'};
    final List<Offer> offers = await api.listMyOffers(basePath, data, accessToken.accessToken);
    expect(offers.isNotEmpty, true);
  });

  test('list-my-projects-offers', () async {
    var data = {'status': '1', 'project_id_list': [1]};
    final List<Offer> offers = await api.listMyProjectsOffers(basePath, data, accessToken.accessToken);
    expect(offers.isEmpty, true);
  });

  test('create-my-organization-offer', () async {

    var data = {'title': 'project1', 'status': 2};
    final Project projects = await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
    'project_id': projects.id,
    'offer_message': 'test offer',
    'message_subject': 'test',
    'status': 1
    };
    final Offer offers = await api.createMyOrganizationOffer(basePath, createOfferData, accessToken.accessToken);
    expect(offers.offerMessage, 'test offer');
  });

  test('create-my-offer', () async {

    var data = {'title': 'project1', 'status': 2};
    final Project projects = await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOffer(basePath, createOfferData, accessToken.accessToken);
    expect(offers.offerMessage, 'test offer');
  });

  test('update-my-organization-offer', () async {

    var data = {'title': 'project1', 'status': 2};
    final Project projects = await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOrganizationOffer(basePath, createOfferData, accessToken.accessToken);

    var updateOfferData = {
      'offer_id': offers.id,
      'project_id': projects.id,
      'offer_message': 'updated test offer',
      'message_subject': 'updated test',
      'status': 2
    };

    final Offer updatedOffer = await api.updateMyOrganizationOffer(basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.offerMessage, 'updated test offer');

  });

  test('update-my-offer', () async {

    var data = {'title': 'project1', 'status': 2};
    final Project projects = await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOffer(basePath, createOfferData, accessToken.accessToken);

    var updateOfferData = {
      'offer_id': offers.id,
      'project_id': projects.id,
      'offer_message': 'updated test offer',
      'message_subject': 'updated test',
      'status': 2
    };

    final Offer updatedOffer = await api.updateMyOffer(basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.offerMessage, 'updated test offer');

  });

  test('update-my-organization-offer', () async {

    var data = {'title': 'project1', 'status': 2};
    final Project projects = await api.createMyProject(basePath, data, accessToken.accessToken);

    var createOfferData = {
      'project_id': projects.id,
      'offer_message': 'test offer',
      'message_subject': 'test',
      'status': 1
    };
    final Offer offers = await api.createMyOrganizationOffer(basePath, createOfferData, accessToken.accessToken);

    var updateOfferData = {
      'offer_id': offers.id,
      'answer_message': 'answer message',
      'status': 2,
      'lock_version': offers.lockVersion,
    };

    final Offer updatedOffer = await api.answerOfferToMyOrganization(basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.answerMessage, 'answer message');

  });


  test('update-my-organization-offer', () async {

    var updateOfferData = {
      'offer_id': 2,
      'answer_message': 'answer message',
      'status': 2,
      'lock_version': 1,
    };

    final Offer updatedOffer = await api.answerOfferToMe(basePath, updateOfferData, accessToken.accessToken);
    expect(updatedOffer.answerMessage, 'answer message');

  });



}