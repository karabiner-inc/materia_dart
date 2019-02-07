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



}