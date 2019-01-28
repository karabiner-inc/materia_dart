import 'package:flutter_test/flutter_test.dart';
import 'package:materia_dart/models/materia/account.dart';
import 'package:materia_dart/models/materia/token.dart';
import 'package:materia_dart/models/materia/user.dart';
import 'package:materia_dart/services/materia_api.dart';

const String basePath='http://localhost:4001/api';


// You need run MIX_ENV=test mix phx.server if you test.

void main() {

  test('signIn', () async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await signIn(basePath, data);
    expect(token.id, 1);
  });

  test('refresh', () async {

    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await signIn(basePath, data);

    data = {
      'refresh_token': token.refreshToken,
    };
    final Token reToken = await refresh(basePath, data);
    expect(reToken.id, 1);

  });



}
