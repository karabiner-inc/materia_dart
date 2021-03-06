import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import '../models/materia/account.dart';
import '../models/materia/address.dart';
import '../models/materia/token.dart';
import '../models/materia/user.dart';
import '../models/materia/grant.dart';
import '../models/materia/mail_template.dart';
import '../models/materia/organization.dart';
import '../models/materia/response_auth.dart';
import './base_api.dart';

class MateriaAPI extends BaseAPI {
  // no auth
  Future<Token> signIn(String basePath, dynamic data) async {
    final String path = p.join(basePath, 'sign-in');
    final http.Response response = await post(path, data);
    return Token.fromJson(json.decode(response.body));
  }

  Future<Token> refresh(String basePath, dynamic data) async {
    final String path = p.join(basePath, 'refresh');
    final http.Response response = await post(path, data);
    return Token.fromJson(json.decode(response.body));
  }

  Future<Token> tmpRegistration(
      String basePath, dynamic data) async {
    final String path = p.join(basePath, 'tmp-registration');
    final http.Response response = await post(path, data);
    return Token.fromJson(json.decode(response.body));
  }

  Future<Token> requestPasswordReset(
      String basePath, dynamic data) async {
    final String path = p.join(basePath, 'request-password-reset');
    final http.Response response = await post(path, data);
    return Token.fromJson(json.decode(response.body));
  }

// tmp_user_auth
  Future<ResponseAuth> validationTmpUser(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'validation-tmp-user');
    final http.Response response = await get(path, token: token);
    return ResponseAuth.fromJson(json.decode(response.body));
  }

  Future<User> userRegistration(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'user-registration');
    final http.Response response = await post(path, data, token: token);
    return User.fromJson(json.decode(response.body));
  }

  Future<Token> userRegistrationAndSignIn(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'user-registration-and-sign-in');
    final http.Response response = await post(path, data, token: token);
    return Token.fromJson(json.decode(response.body));
  }

//// pw_reset_auth
  Future<ResponseAuth> validationPwReset(String basePath, String token) async {
    final String path = p.join(basePath, 'validation-pw-reset');
    final http.Response response = await get(path, token: token);
    return ResponseAuth.fromJson(json.decode(response.body));
  }

  Future<User> resetMyPassword(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'reset-my-password');
    final http.Response response = await post(path, data, token: token);
    return User.fromJson(json.decode(response.body));
  }

// guardian_auth
  Future<User> showMe(String basePath, String token) async {
    final String path = p.join(basePath, 'user');
    final http.Response response = await get(path, token: token);
    return User.fromJson(json.decode(response.body));
  }

  Future<List<Grant>> getByRole(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'grant');
    final http.Response response = await post(path, data, token: token);
    return Grant.fromListJson(json.decode(response.body));
  }

  Future<dynamic> signOut(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'sign-out');
    final http.Response response = await post(path, data, token: token);
    return json.decode(response.body);
  }

  Future<dynamic> authCheck(String basePath, String token) async {
    final String path = p.join(basePath, 'auth-check');
    final http.Response response = await get(path, token: token);
    return json.decode(response.body);
  }

  Future<List<User>> searchUsers(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'search-users');
    final http.Response response = await post(path, data, token: token);
    return User.fromListJson(json.decode(response.body));
  }

  Future<List<Address>> getAddresses(String basePath, String token) async {
    final String path = p.join(basePath, 'addresses');
    final http.Response response = await get(path, token: token);
    return Address.fromListJson(json.decode(response.body));
  }

  Future<Address> getAddress(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'addresses/${data['id']}');
    final http.Response response = await get(path, token: token);
    return Address.fromJson(json.decode(response.body));
  }

  Future<Address> createAddress(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'addresses');
    final http.Response response = await post(path, data, token: token);
    return Address.fromJson(json.decode(response.body));
  }

  Future<Address> updateAddress(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'addresses/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return Address.fromJson(json.decode(response.body));
  }

  Future<bool> deleteAddress(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'addresses/${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<Address> createMyAddress(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'create-my-address');
    final http.Response response = await post(path, data, token: token);
    return Address.fromJson(json.decode(response.body));
  }

  Future<List<Account>> getAccounts(String basePath, String token) async {
    final String path = p.join(basePath, 'accounts');
    final http.Response response = await get(path, token: token);
    return Account.fromListJson(json.decode(response.body));
  }

  Future<Account> getAccount(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'accounts/${data['id']}');
    final http.Response response = await get(path, token: token);
    return Account.fromJson(json.decode(response.body));
  }

  Future<Account> createAccount(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'accounts');
    final http.Response response = await post(path, data, token: token);
    return Account.fromJson(json.decode(response.body));
  }

  Future<Account> updateAccount(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'accounts/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return Account.fromJson(json.decode(response.body));
  }

  Future<bool> deleteAccount(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'accounts/${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<List<Account>> searchAccounts(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'search-accounts');
    final http.Response response = await post(path, data, token: token);
    return Account.fromListJson(json.decode(response.body));
  }

  Future<Token> signInWithAccount(
      String basePath, dynamic data) async {
    final String path = p.join(basePath, 'sign-in');
    final http.Response response = await post(path, data);
    return Token.fromJson(json.decode(response.body));
  }

  Future<Account> getMyAccount(String basePath, String token) async {
    final String path = p.join(basePath, 'my-account');
    final http.Response response = await get(path, token: token);
    return Account.fromJson(json.decode(response.body));
  }

// Grants
  Future<List<Grant>> getGrants(String basePath, String token) async {
    final String path = p.join(basePath, 'grants');
    final http.Response response = await get(path, token: token);
    return Grant.fromListJson(json.decode(response.body));
  }

  Future<Grant> getGrant(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'grants/${data['id']}');
    final http.Response response = await get(path, token: token);
    return Grant.fromJson(json.decode(response.body));
  }

  Future<Grant> createGrant(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'grants');
    final http.Response response = await post(path, data, token: token);
    return Grant.fromJson(json.decode(response.body));
  }

  Future<Grant> updateGrant(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'grants/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return Grant.fromJson(json.decode(response.body));
  }

  Future<bool> deleteGrant(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'grants/${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

// MailTemplate
  Future<List<MailTemplate>> getMailTemplates(
      String basePath, String token) async {
    final String path = p.join(basePath, 'mail-templates');
    final http.Response response = await get(path, token: token);
    return MailTemplate.fromListJson(json.decode(response.body));
  }

  Future<MailTemplate> getMailTemplate(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'mail-templates/${data['id']}');
    final http.Response response = await get(path, token: token);
    return MailTemplate.fromJson(json.decode(response.body));
  }

  Future<MailTemplate> createMailTemplate(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'mail-templates');
    final http.Response response = await post(path, data, token: token);
    return MailTemplate.fromJson(json.decode(response.body));
  }

  Future<MailTemplate> updateMailTemplate(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'mail-templates/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return MailTemplate.fromJson(json.decode(response.body));
  }

  Future<bool> deleteMailTemplate(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'mail-templates/${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

// User
  Future<List<User>> getUsers(String basePath, String token) async {
    final String path = p.join(basePath, 'users');
    final http.Response response = await get(path, token: token);
    return User.fromListJson(json.decode(response.body));
  }

  Future<User> getUser(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'users/${data['id']}');
    final http.Response response = await get(path, token: token);
    return User.fromJson(json.decode(response.body));
  }

  Future<User> createUser(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'users');
    final http.Response response = await post(path, data, token: token);
    return User.fromJson(json.decode(response.body));
  }

  Future<User> updateUser(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'users/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return User.fromJson(json.decode(response.body));
  }

  Future<bool> deleteUser(String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'users/${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

// Organization
  Future<List<Organization>> getOrganizations(
      String basePath, String token) async {
    final String path = p.join(basePath, 'organizations');
    final http.Response response = await get(path, token: token);
    return Organization.fromListJson(json.decode(response.body));
  }

  Future<Organization> getOrganization(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'organizations/${data['id']}');
    final http.Response response = await get(path, token: token);
    return Organization.fromJson(json.decode(response.body));
  }

  Future<Organization> createOrganization(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'organizations');
    final http.Response response = await post(path, data, token: token);
    return Organization.fromJson(json.decode(response.body));
  }

  Future<Organization> updateOrganization(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'organizations/${data['id']}');
    final http.Response response = await put(path, data, token: token);
    return Organization.fromJson(json.decode(response.body));
  }

  Future<bool> deleteOrganization(
      String basePath, dynamic data, String token) async {
    final String path = p.join(basePath, 'organizations/${data['id']}');
    final http.Response response = await delete(path, token: token);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }
}
