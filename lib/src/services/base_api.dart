import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class BaseAPI {
  
  Future<http.Response> get(String path, {String token = ''}) async {
    return http.get(path, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  Future<http.Response> post(String path, Map<String, dynamic> data,
      {String token = ''}) async {
    return http.post(path, body: json.encode(data), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  Future<http.Response> put(String path, Map<String, dynamic> data,
      {String token = ''}) async {
    return http.put(path, body: json.encode(data), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  Future<http.Response> delete(String path, {String token = ''}) async {
    return http.delete(path, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }
}
