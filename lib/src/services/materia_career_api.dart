import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'materia_api.dart';
import '../models/materia_career/offer.dart';
import '../models/materia_career/project.dart';
import '../models/materia_career/record.dart';
import '../models/materia_career/skill.dart';

class MateriaCareerAPI extends MateriaAPI {
  //  projects with auth
  Future<List<Project>> listMyProjects(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'list-my-projects');
    final http.Response response = await post(path, data, token: token);
    return Project.fromListJson(json.decode(response.body));
  }

  Future<Project> createMyProject(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-project');
    final http.Response response = await post(path, data, token: token);
    return Project.fromJson(json.decode(response.body));
  }

  Future<Project> updateMyProject(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'update-my-project');
    final http.Response response = await post(path, data, token: token);
    return Project.fromJson(json.decode(response.body));
  }

  // projects
  Future<List<Project>> listProjects(String basePath) async {
    final String path = p.join(basePath, 'projects');
    final http.Response response = await get(path);
    return Project.fromListJson(json.decode(response.body));
  }

  Future<Project> getProject(String basePath, int projectId) async {
    final String path = p.join(basePath, 'projects/$projectId');
    final http.Response response = await get(path);
    return Project.fromJson(json.decode(response.body));
  }

  //  offers
  Future<List<Offer>> listMyOffers(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'list-my-offers');
    final http.Response response = await get(path + '?status=${data['status']}', token: token);
    return Offer.fromListJson(json.decode(response.body));
  }

  Future<List<Offer>> listMyProjectsOffers(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'list-my-projects-offers');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromListJson(json.decode(response.body));
  }

  Future<Offer> createMyOrganizationOffer(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-organization-offer');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromJson(json.decode(response.body));
  }

  Future<Offer> createMyOffer(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-offer');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromJson(json.decode(response.body));
  }

  Future<Offer> updateMyOrganizationOffer(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'update-my-organization-offer');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromJson(json.decode(response.body));
  }

  Future<Offer> updateMyOffer(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'update-my-offer');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromJson(json.decode(response.body));
  }

  Future<Offer> answerOfferToMyOrganization(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'answer-offer-to-my-organization');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromJson(json.decode(response.body));
  }

  Future<Offer> answerOfferToMe(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'answer-offer-to-me');
    final http.Response response = await post(path, data, token: token);
    return Offer.fromJson(json.decode(response.body));
  }

  //  records
  Future<List<Record>> listMyRecords(String basePath, String token) async {
    final String path = p.join(basePath, 'list-my-records');
    final http.Response response = await get(path, token: token);
    return Record.fromListJson(json.decode(response.body));
  }

  Future<Record> createMyRecord(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-record');
    final http.Response response = await post(path, data, token: token);
    return Record.fromJson(json.decode(response.body));
  }

  Future<Record> updateMyRecord(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'update-my-record');
    final http.Response response = await post(path, data, token: token);
    return Record.fromJson(json.decode(response.body));
  }

  // skills
  Future<List<Skill>> listMySkills(String basePath, String token) async {
    final String path = p.join(basePath, 'list-my-skills');
    final http.Response response = await get(path, token: token);
    return Skill.fromListJson(json.decode(response.body));
  }

  Future<Skill> createMySkill(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-skill');
    final http.Response response = await post(path, data, token: token);
    return Skill.fromJson(json.decode(response.body));
  }

  Future<Skill> updateMySkill(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'update-my-skill');
    final http.Response response = await put(path, data, token: token);
    return Skill.fromJson(json.decode(response.body));
  }

  Future<bool> deleteMySkill(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'delete-my-skill?id=${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

}