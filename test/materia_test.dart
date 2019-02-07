import 'package:test/test.dart';
import 'package:materia_dart/materia_dart.dart';

const String basePath='http://localhost:4001/api';
const String basePathOps='http://localhost:4001/api/ops';


// You need run MIX_ENV=test mix phx.server if you test.

void main() {

  Token accessToken;
  Token accessTokenForAccount;
  MateriaAPI api = MateriaAPI();


  String _timestamp() => (DateTime.now().millisecondsSinceEpoch + 1).toString();


  setUpAll(() async{
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accessToken = await api.signIn(basePath, data);
    data = {
      'account': 'hogehoge_code',
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    accessTokenForAccount = await api.signInWithAccount(basePath, data);


  });

  test('signIn with User', () async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await api.signIn(basePath, data);
    expect(token.id, 1);
  });

  test('signIn with Account', () async {
    var data = {
      'account': 'hogehoge_code',
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await api.signInWithAccount(basePath, data);
    expect(token.id, 1);
  });

  test('refresh', () async {

    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await api.signIn(basePath, data);

    data = {
      'refresh_token': token.refreshToken,
    };
    final Token reToken = await api.refresh(basePath, data);
    expect(reToken.id, 1);

  });

  test('tmp-registration', () async {

    final String timestamp = _timestamp();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final Token tmpToken = await api.tmpRegistration(basePath, data);
    expect(tmpToken.user.email, email);

  });

  test('request_password_reset', () async {
    var data = {
      'email': 'hogehoge@example.com',
    };
    final Token result = await api.requestPasswordReset(basePath, data);
    expect(result.passwordResetToken.isNotEmpty, true);
  });

  test('validation-tmp-user', () async {
    final String timestamp = _timestamp();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final Token tmpToken = await api.tmpRegistration(basePath, data);
    data = {
      'email': tmpToken.user.email
    };
    final ResponseAuth result = await api.validationTmpUser(basePath, data, tmpToken.userRegistrationToken);
    expect(result.message, 'authenticated');
  });

  test('user-registration', () async {
    final String timestamp = _timestamp();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final Token tmpToken = await api.tmpRegistration(basePath, data);
    var createUserData = {
      'name': 'hogehoge$timestamp',
      'email': tmpToken.user.email,
      'password': 'password',
      'password_confimation': 'password'
    };
    final User user = await api.userRegistration(basePath, createUserData, tmpToken.userRegistrationToken);
    expect(user.email, tmpToken.user.email);
  });

  test('user-registration-and-sign-in', () async {
    final String timestamp = _timestamp();
    final String email = 'hogehoge$timestamp@example.com';
    var data = {
      'email': email,
      'role': 'test',
    };
    final Token tmpToken = await api.tmpRegistration(basePath, data);
    var createUserData = {
      'name': 'hogehoge$timestamp',
      'email': tmpToken.user.email,
      'password': 'password',
      'password_confimation': 'password'
    };
    final Token token = await api.userRegistrationAndSignIn(basePath, createUserData, tmpToken.userRegistrationToken);
    expect(token.user.id, tmpToken.user.id);
  });

  test('validation-pw-reset', () async {
    var data = {
      'email': 'hogehoge@example.com',
    };
    final Token password = await api.requestPasswordReset(basePath, data);
    final ResponseAuth result = await api.validationPwReset(basePath, password.passwordResetToken);
    expect(result.message, 'authenticated');
  });

  test('reset-my-password', () async {
    var data = {
      'email': 'hogehoge@example.com',
    };
    final Token password = await api.requestPasswordReset(basePath, data);
    var rePwdData = {
      'password': 'hogehoge'
    };
    final User user = await api.resetMyPassword(basePath, rePwdData, password.passwordResetToken);
    expect(user.email, 'hogehoge@example.com');
  });

  test('show me', () async {
    final User user = await api.showMe(basePath, accessToken.accessToken);
    expect(user.email, 'hogehoge@example.com');
  });

  test('get_by_role', () async {
    var role = {
      'role': 'anybody'
    };
    final List<Grant> grants = await api.getByRole(basePath, role,  accessToken.accessToken);
    expect(grants[0].role, 'anybody');
  });

  test('sign out', () async {
    var data = {
      'email': 'hogehoge@example.com',
      'password': 'hogehoge',
    };
    final Token token = await api.signIn(basePath, data);
    final Map<String, dynamic> requestData = Map<String, dynamic>();
    final dynamic result = await api.signOut(basePath, requestData,  token.accessToken);
    expect(result['ok'], true);
  });

  test('auth-check', () async {
    final dynamic result = await api.authCheck(basePath, accessToken.accessToken);
    expect(result['message'], 'authenticated');
  });

  test('search-users', () async {
    final Map<String, dynamic> requestData = Map<String, dynamic>();
    final List<User> result = await api.searchUsers(basePath, requestData,  accessToken.accessToken);
    expect(result.isNotEmpty, true);
  });

  test('create and get address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await api.createAddress(basePath, requestData,  accessToken.accessToken);
    expect(result1.address1, 'test1');

    requestData = {
      'id': result1.id,
    };
    final Address result2 = await api.getAddress(basePath, requestData,  accessToken.accessToken);
    expect(result2.address1, 'test1');

    final List<Address> result3 = await api.getAddresses(basePath, accessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await api.createAddress(basePath, requestData,  accessToken.accessToken);
    expect(result1.address1, 'test1');


    requestData = {
      'id': result1.id,
      'address1': 'test2',
      'subject': 'address'
    };
    final Address result2 = await api.updateAddress(basePath, requestData,  accessToken.accessToken);
    expect(result2.address1, 'test2');

  });

  test('create and delete address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await api.createAddress(basePath, requestData,  accessToken.accessToken);
    expect(result1.address1, 'test1');

    requestData = {
      'id': result1.id,
    };
    final bool result2 = await api.deleteAddress(basePath, requestData, accessToken.accessToken);
    expect(result2, true);
  });

  test('create my address', () async {
    dynamic requestData = {
      'address1': 'test1',
      'subject': 'address'
    };
    final Address result1 = await api.createMyAddress(basePath, requestData,  accessToken.accessToken);
    expect(result1.address1, 'test1');

  });

  test('create and get account', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'test1',
      'external_code': 'test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result1 = await api.createAccount(basePath, requestData,  accessToken.accessToken);
    expect(result1.externalCode, 'test$timestamp');

    requestData = {
      'id': result1.id,
    };
    final Account result2 = await api.getAccount(basePath, requestData,  accessToken.accessToken);
    expect(result2.name, 'test1');
  });

  test('get accounts', () async {
    final List<Account> result3 = await api.getAccounts(basePath, accessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update account', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'test1',
      'external_code': 'test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result1 = await api.createAccount(basePath, requestData,  accessToken.accessToken);

    requestData = {
      'id': result1.id,
      'name': 'test2',
      'external_code': 'update_test$timestamp',
      'start_date': '2019-01-01T12:00:00Z'
    };
    final Account result2 = await api.updateAccount(basePath, requestData,  accessToken.accessToken);
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
    final Account result1 = await api.createAccount(basePath, requestData,  accessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await api.deleteAccount(basePath, requestData, accessToken.accessToken);
    expect(result2, true);
  });

  test('search-accounts', () async {
    final dynamic requestData = Map<String, dynamic>();
    final List<Account> result = await api.searchAccounts(basePath, requestData,  accessToken.accessToken);
    expect(result.isNotEmpty, true);
  });


  test('my-account', () async {
    final Account result = await api.getMyAccount(basePath, accessTokenForAccount.accessToken);
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
    final Grant result1 = await api.createGrant(basePathOps, requestData,  accessToken.accessToken);
    expect(result1.role, 'anybody$timestamp');

    requestData = {
      'id': result1.id,
    };
    final Grant result2 = await api.getGrant(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.role, 'anybody$timestamp');
  });

  test('get grants', () async {
    final List<Grant> result3 = await api.getGrants(basePathOps, accessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update grant', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'role': 'anybody$timestamp',
      'method': 'ANY',
      'request_path': '/api/test'
    };
    final Grant result1 = await api.createGrant(basePathOps, requestData,  accessToken.accessToken);

    requestData = {
      'id': result1.id,
      'role': 'anybody$timestamp',
      'method': 'GET',
      'request_path': '/api/test'
    };
    final Grant result2 = await api.updateGrant(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.method, 'GET');

  });

  test('create and delete grant', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'role': 'anybody$timestamp',
      'method': 'ANY',
      'request_path': '/api/test'
    };
    final Grant result1 = await api.createGrant(basePathOps, requestData,  accessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await api.deleteGrant(basePathOps, requestData, accessToken.accessToken);
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
    final MailTemplate result1 = await api.createMailTemplate(basePathOps, requestData,  accessToken.accessToken);
    expect(result1.mailTemplateType, 'test$timestamp');

    requestData = {
      'id': result1.id,
    };
    final MailTemplate result2 = await api.getMailTemplate(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.mailTemplateType, 'test$timestamp');
  });

  test('get mail-templates', () async {
    final List<MailTemplate> result3 = await api.getMailTemplates(basePathOps, accessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update mail-templates', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'body': 'testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result1 = await api.createMailTemplate(basePathOps, requestData,  accessToken.accessToken);

    requestData = {
      'id': result1.id,
      'body': 'update testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result2 = await api.updateMailTemplate(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.body, 'update testbody');

  });

  test('create and delete mail-templates', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'body': 'testbody',
      'subject': 'testsubject',
      'mail_template_type': 'test$timestamp'
    };
    final MailTemplate result1 = await api.createMailTemplate(basePathOps, requestData,  accessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await api.deleteMailTemplate(basePathOps, requestData, accessToken.accessToken);
    expect(result2, true);
  });

  //  Users
  test('create and get users', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'hogehoge$timestamp',
      'email': 'hogehoge$timestamp@example.com',
      'password': 'password',
      'password_confimation': 'password',
      'role': 'client'
    };
    final User result1 = await api.createUser(basePathOps, requestData,  accessToken.accessToken);

    expect(result1.name, 'hogehoge$timestamp');

    requestData = {
      'id': result1.id,
    };
    final User result2 = await api.getUser(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.name, 'hogehoge$timestamp');
  });

  test('get users', () async {
    final List<User> result3 = await api.getUsers(basePathOps, accessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update users', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'hogehoge$timestamp',
      'email': 'hogehoge$timestamp@example.com',
      'password': 'password',
      'password_confimation': 'password',
      'role': 'client'
    };
    final User result1 = await api.createUser(basePathOps, requestData,  accessToken.accessToken);

    requestData = {
      'id': result1.id,
      'name': 'updatehogehoge$timestamp',
      'email': 'hogehoge$timestamp@example.com',
      'password': 'password',
      'password_confimation': 'password'
    };
    final User result2 = await api.updateUser(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.name, 'updatehogehoge$timestamp');

  });

  test('create and delete users', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'hogehoge$timestamp',
      'email': 'hogehoge$timestamp@example.com',
      'password': 'password',
      'password_confimation': 'password',
      'role': 'client'
    };
    final User result1 = await api.createUser(basePathOps, requestData,  accessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await api.deleteUser(basePathOps, requestData, accessToken.accessToken);
    expect(result2, true);
  });

  // Organizations
  test('create and get organizations', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'hogehoge$timestamp',
    };
    final Organization result1 = await api.createOrganization(basePathOps, requestData,  accessToken.accessToken);

    expect(result1.name, 'hogehoge$timestamp');

    requestData = {
      'id': result1.id,
    };
    final Organization result2 = await api.getOrganization(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.name, 'hogehoge$timestamp');
  });

  test('get organizations', () async {
    final List<Organization> result3 = await api.getOrganizations(basePathOps, accessToken.accessToken);
    expect(result3.isNotEmpty, true);
  });

  test('create and update organizations', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'hogehoge$timestamp',
    };
    final Organization result1 = await api.createOrganization(basePathOps, requestData,  accessToken.accessToken);

    requestData = {
      'id': result1.id,
      'name': 'updatehogehoge$timestamp',
    };
    final Organization result2 = await api.updateOrganization(basePathOps, requestData,  accessToken.accessToken);
    expect(result2.name, 'updatehogehoge$timestamp');

  });

  test('create and delete organizations', () async {
    final String timestamp = _timestamp();

    dynamic requestData = {
      'name': 'hogehoge$timestamp',
    };
    final Organization result1 = await api.createOrganization(basePathOps, requestData,  accessToken.accessToken);
    requestData = {
      'id': result1.id,
    };
    final bool result2 = await api.deleteOrganization(basePathOps, requestData, accessToken.accessToken);
    expect(result2, true);
  });
}
