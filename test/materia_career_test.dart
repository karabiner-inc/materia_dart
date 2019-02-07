import 'package:test/test.dart';
import 'package:materia_dart/materia_career_dart.dart';
import 'package:materia_dart/materia_dart.dart';

const String basePath='http://localhost:4001/api';
const String basePathOps='http://localhost:4001/api/ops';

void main() {

  Token accessToken;
  Token accessTokenForAccount;
  MateriaCareerAPI api = MateriaCareerAPI();
  MateriaAPI materiaApi = MateriaAPI();

  String _timestamp() => (DateTime.now().millisecondsSinceEpoch + 1).toString();

  setUpAll(() async{
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accessToken = await materiaApi.signIn(basePath, data);
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

  
}