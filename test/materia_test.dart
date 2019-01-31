import 'package:flutter_test/flutter_test.dart';

import 'package:materia_dart/models/materia/account.dart';
import 'package:materia_dart/models/materia/address.dart';
import 'package:materia_dart/models/materia/grant.dart';
import 'package:materia_dart/models/materia/mail_template.dart';
import 'package:materia_dart/models/materia/token.dart';
import 'package:materia_dart/models/materia/user.dart';
import 'package:materia_dart/models/materia/tmp_token.dart';
import 'package:materia_dart/models/materia/password_reset_token.dart';

import 'package:materia_dart/services/materia_api.dart';

const String basePath='http://localhost:4001/api';
const String basePathOps='http://localhost:4001/api/ops';


// You need run MIX_ENV=test mix phx.server if you test.

void main() {

  Token accsessToken;
  Token accsessTokenForAccount;


  String _timestamp() => (DateTime.now().millisecondsSinceEpoch + 1).toString();


  setUpAll(() async{
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accsessToken = await signIn(basePath, data);
    data = {
      'account': 'hogehoge_code',
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accsessTokenForAccount = await signInWithAccount(basePath, data);


  });

  test('signIn with User', () async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await signIn(basePath, data);
    expect(token.id, 1);
  });

  test('signIn with Account', () async {
    var data = {
      'account': 'hogehoge_code',
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await signInWithAccount(basePath, data);
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

    final String timestamp = _timestamp();
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
    final String timestamp = _timestamp();
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
    final String timestamp = _timestamp();
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
    final String timestamp = _timestamp();
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

  test('show me', () async {
    final User user = await showMe(basePath, accsessToken.accessToken);
    expect(user.email, 'hogehoge@example.com');
  });

  test('get_by_role', () async {
    var role = {
      'role': 'anybody'
    };
    final List<Grant> grants = await getByRole(basePath, role,  accsessToken.accessToken);
    expect(grants[0].role, 'anybody');
  });

  test('sign out', () async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await signIn(basePath, data);
    final Map<String, dynamic> requestData = Map<String, dynamic>();
    final dynamic result = await signOut(basePath, requestData,  token.accessToken);
    expect(result['ok'], true);
  });

  test('auth-check', () async {
    final dynamic result = await authCheck(basePath, accsessToken.accessToken);
    expect(result['message'], 'authenticated');
  });

  test('search-users', () async {
    final Map<String, dynamic> requestData = Map<String, dynamic>();
    final List<User> result = await searchUsers(basePath, requestData,  accsessToken.accessToken);
    expect(result.isNotEmpty, true);
  });

  test('create and get address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await createAddress(basePath, requestData,  accsessToken.accessToken);
    expect(result1.address1, 'test1');

    requestData = {
      'id': result1.id,
    };
    final Address result2 = await getAddress(basePath, requestData,  accsessToken.accessToken);
    expect(result2.address1, 'test1');

    final List<Address> result3 = await getAddresses(basePath, accsessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await createAddress(basePath, requestData,  accsessToken.accessToken);
    expect(result1.address1, 'test1');


    requestData = {
      'id': result1.id,
      'address1': 'test2',
      'subject': 'address'
    };
    final Address result2 = await updateAddress(basePath, requestData,  accsessToken.accessToken);
    expect(result2.address1, 'test2');

  });

  test('create and delete address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await createAddress(basePath, requestData,  accsessToken.accessToken);
    expect(result1.address1, 'test1');

    requestData = {
      'id': result1.id,
    };
    final bool result2 = await deleteAddress(basePath, requestData, accsessToken.accessToken);
    expect(result2, true);
  });

  test('create my address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await createMyAddress(basePath, requestData,  accsessToken.accessToken);
    expect(result1.address1, 'test1');

  });

  test('create and get account', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'test1',
      'external_code': 'test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result1 = await createAccount(basePath, requestData,  accsessToken.accessToken);
    expect(result1.externalCode, 'test$timestamp');

    requestData = {
      'id': result1.id,
    };
    final Account result2 = await getAccount(basePath, requestData,  accsessToken.accessToken);
    expect(result2.name, 'test1');
  });

  test('get accounts', () async {
    final List<Account> result3 = await getAccounts(basePath, accsessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update account', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'test1',
      'external_code': 'test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result1 = await createAccount(basePath, requestData,  accsessToken.accessToken);

    requestData = {
      'id': result1.id,
      'name': 'test2',
      'external_code': 'update_test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result2 = await updateAccount(basePath, requestData,  accsessToken.accessToken);
    expect(result2.name, 'test2');
    expect(result2.externalCode, 'update_test$timestamp');

  });

  test('create and delete account', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'test1',
      'external_code': 'test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result1 = await createAccount(basePath, requestData,  accsessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await deleteAccount(basePath, requestData, accsessToken.accessToken);
    expect(result2, true);
  });

  test('search-accounts', () async {
    final dynamic requestData = Map<String, dynamic>();
    final List<Account> result = await searchAccounts(basePath, requestData,  accsessToken.accessToken);
    expect(result.isNotEmpty, true);
  });


  test('my-account', () async {
    final Account result = await getMyAccount(basePath, accsessTokenForAccount.accessToken);
    expect(result.name, 'hogehoge account');
  });

//  Grant

  test('create and get grant', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'role': 'anybody$timestamp',
      'method': 'ANY',
      'request_path': '/api/test'
    };
    final Grant result1 = await createGrant(basePathOps, requestData,  accsessToken.accessToken);
    expect(result1.role, 'anybody$timestamp');

    requestData = {
      'id': result1.id,
    };
    final Grant result2 = await getGrant(basePathOps, requestData,  accsessToken.accessToken);
    expect(result2.role, 'anybody$timestamp');
  });

  test('get grants', () async {
    final List<Grant> result3 = await getGrants(basePathOps, accsessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update grant', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'role': 'anybody$timestamp',
      'method': 'ANY',
      'request_path': '/api/test'
    };
    final Grant result1 = await createGrant(basePathOps, requestData,  accsessToken.accessToken);

    requestData = {
      'id': result1.id,
      'role': 'anybody$timestamp',
      'method': 'GET',
      'request_path': '/api/test'
    };
    final Grant result2 = await updateGrant(basePathOps, requestData,  accsessToken.accessToken);
    expect(result2.method, 'GET');

  });

  test('create and delete grant', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'role': 'anybody$timestamp',
      'method': 'ANY',
      'request_path': '/api/test'
    };
    final Grant result1 = await createGrant(basePathOps, requestData,  accsessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await deleteGrant(basePathOps, requestData, accsessToken.accessToken);
    expect(result2, true);
  });

  // MailTemplate

  test('create and get mail-templates', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'body': 'testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result1 = await createMailTemplate(basePathOps, requestData,  accsessToken.accessToken);
    expect(result1.mailTemplateType, 'test$timestamp');

    requestData = {
      'id': result1.id,
    };
    final MailTemplate result2 = await getMailTemplate(basePathOps, requestData,  accsessToken.accessToken);
    expect(result2.mailTemplateType, 'test$timestamp');
  });

  test('get mail-templates', () async {
    final List<MailTemplate> result3 = await getMailTemplates(basePathOps, accsessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update mail-templates', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'body': 'testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result1 = await createMailTemplate(basePathOps, requestData,  accsessToken.accessToken);

    requestData = {
      'id': result1.id,
      'body': 'update testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result2 = await updateMailTemplate(basePathOps, requestData,  accsessToken.accessToken);
    expect(result2.body, 'update testbody');

  });

  test('create and delete mail-templates', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'body': 'testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result1 = await createMailTemplate(basePathOps, requestData,  accsessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await deleteMailTemplate(basePathOps, requestData, accsessToken.accessToken);
    expect(result2, true);
  });

}
