import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:materia_dart/models/materia/grant.dart';
import 'package:path/path.dart' as p;

import '../models/materia/account.dart';
import '../models/materia/address.dart';
import '../models/materia/token.dart';
import '../models/materia/user.dart';
import '../models/materia/tmp_token.dart';
import '../models/materia/password_reset_token.dart';
import './base_api.dart';

// no auth
Future<Token> signIn(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'sign-in');
  final http.Response response = await post(path, data);
  return Token.fromJson(json.decode(response.body));
}

Future<Token> refresh(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'refresh');
  final http.Response response = await post(path, data);
  return Token.fromJson(json.decode(response.body));
}

Future<TmpToken> tmpRegistration(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'tmp-registration');
  final http.Response response = await post(path, data);
  return TmpToken.fromJson(json.decode(response.body));
}

Future<PasswordResetToken> requestPasswordReset(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'request-password-reset');
  final http.Response response = await post(path, data);
  return PasswordResetToken.fromJson(json.decode(response.body));
}

// tmp_user_auth
Future<Map<String, dynamic>> validationTmpUser(String basePath, Map<String, dynamic> data, String token) async {
  final String path = p.join(basePath, 'validation-tmp-user');
  final http.Response response = await get(path, token: token);
  return json.decode(response.body);
}


Future<User> userRegistration(String basePath, Map<String, dynamic> data, String token) async {
  final String path = p.join(basePath, 'user-registration');
  final http.Response response = await post(path, data, token: token);
  return User.fromJson(json.decode(response.body));
}

Future<Map<String, dynamic>> userRegistrationAndSignIn(String basePath, Map<String, dynamic> data, String token) async {
  final String path = p.join(basePath, 'user-registration-and-sign-in');
  final http.Response response = await post(path, data, token: token);
  return json.decode(response.body);
}

//// pw_reset_auth
Future<Map<String, dynamic>> validationPwReset(String basePath, String token) async {
  final String path = p.join(basePath, 'validation-pw-reset');
  final http.Response response = await get(path, token: token);
  return json.decode(response.body);
}

Future<User> resetMyPassword(String basePath, Map<String, dynamic> data, String token) async {
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

Future<List<Grant>> getByRole(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'grant');
  final http.Response response = await post(path, data, token: token);
  final List<dynamic> decodeResponse = json.decode(response.body);
  return decodeResponse.map((dynamic json) => Grant.fromJson(json)).toList();
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

Future<List<User>> searchUsers(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'search-users');
  final http.Response response = await post(path, data, token: token);
  final List<dynamic> decodeResponse = json.decode(response.body);
  return decodeResponse.map((dynamic json) => User.fromJson(json)).toList();
}


Future<List<Address>> getAddresses(String basePath, String token) async {
  final String path = p.join(basePath, 'addresses');
  final http.Response response = await get(path, token: token);
  return Address.fromListJson(json.decode(response.body));
}

Future<Address> getAddress(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'addresses/${data['id']}');
  final http.Response response = await get(path, token: token);
  return Address.fromJson(json.decode(response.body));
}

Future<Address> createAddress(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'addresses');
  final http.Response response = await post(path, data, token: token);
  return Address.fromJson(json.decode(response.body));
}

Future<Address> updateAddress(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'addresses/${data['id']}');
  final http.Response response = await put(path, data, token: token);
  return Address.fromJson(json.decode(response.body));
}

Future<bool> deleteAddress(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'addresses/${data['id']}');
  final http.Response response = await delete(path, token: token);
  if(response.statusCode == 204) {
    return true;
  }
  return false;
}

Future<Address> createMyAddress(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'create-my-address');
  final http.Response response = await post(path, data, token: token);
  return Address.fromJson(json.decode(response.body));
}

Future<List<Account>> getAccounts(String basePath, String token) async {
  final String path = p.join(basePath, 'accounts');
  final http.Response response = await get(path, token: token);
  return Account.fromListJson(json.decode(response.body));
}

Future<Account> getAccount(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'accounts/${data['id']}');
  final http.Response response = await get(path, token: token);
  return Account.fromJson(json.decode(response.body));
}

Future<Account> createAccount(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'accounts');
  final http.Response response = await post(path, data, token: token);
  return Account.fromJson(json.decode(response.body));
}

Future<Account> updateAccount(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'accounts/${data['id']}');
  final http.Response response = await put(path, data, token: token);
  return Account.fromJson(json.decode(response.body));
}

Future<bool> deleteAccount(String basePath, dynamic data, String token) async {
  final String path = p.join(basePath, 'accounts/${data['id']}');
  final http.Response response = await delete(path, token: token);
  if(response.statusCode == 204) {
    return true;
  }
  return false;
}