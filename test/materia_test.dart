import 'package:flutter_test/flutter_test.dart';

import 'package:materia_dart/models/materia/account.dart';
import 'package:materia_dart/models/materia/token.dart';
import 'package:materia_dart/models/materia/user.dart';
import 'package:materia_dart/models/materia/tmp_token.dart';
import 'package:materia_dart/models/materia/password_reset_token.dart';

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

  test('tmp-registration', () async {

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final TmpToken tmpToken = await tmpRegistration(basePath, data);
    expect(tmpToken.user.email, email);


  });

  test('request_password_reset', () async {
    var data = {
      'email': 'hogehoge@example.com',
    };
    final PasswordResetToken result = await requestPasswordReset(basePath, data);
    expect(result.passwordResetToken.isNotEmpty, true);
  });

  test('validation-tmp-user', () async {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final TmpToken tmpToken = await tmpRegistration(basePath, data);
    data = {
      'email': tmpToken.user.email
    };
    final Map<String, dynamic> result = await validationTmpUser(basePath, data, tmpToken.userRegistrationToken);
    expect(result['message'], 'authenticated');
  });

  test('user-registration', () async {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final TmpToken tmpToken = await tmpRegistration(basePath, data);
    var createUserData = {
      'name': 'hogehoge$timestamp',
      'email': tmpToken.user.email,
      'password': 'password',
      'password_confimation': 'password'
    };
    final User user = await userRegistration(basePath, createUserData, tmpToken.userRegistrationToken);
    expect(user.email, tmpToken.user.email);
  });

  test('user-registration-and-sign-in', () async {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final TmpToken tmpToken = await tmpRegistration(basePath, data);
    var createUserData = {
      'name': 'hogehoge$timestamp',
      'email': tmpToken.user.email,
      'password': 'password',
      'password_confimation': 'password'
    };
    final Map<String, dynamic> token = await userRegistrationAndSignIn(basePath, createUserData, tmpToken.userRegistrationToken);
    expect(token['user']['id'], tmpToken.user.id);
  });

  test('validation-pw-reset', () async {
    var data = {
      'email': 'hogehoge@example.com',
    };
    final PasswordResetToken password = await requestPasswordReset(basePath, data);
    final Map<String, dynamic> result = await validationPwReset(basePath, password.passwordResetToken);
    expect(result['message'], 'authenticated');
  });

  test('reset-my-password', () async {
    var data = {
      'email': 'hogehoge@example.com',
    };
    final PasswordResetToken password = await requestPasswordReset(basePath, data);
    var rePwdData = {
      'password': 'hogehoge'
    };
    final User user = await resetMyPassword(basePath, rePwdData, password.passwordResetToken);
    expect(user.email, 'hogehoge@example.com');
  });

}
