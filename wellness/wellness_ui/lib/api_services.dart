import 'dart:convert';

import 'package:http/http.dart' as http;


const String baseUrl = "http://192.168.5.214:11333/wellness/";

class ApiResponse {
  final int statusCode;
  final dynamic body;
  ApiResponse(this.statusCode, this.body);
}

class ApiService {
  var client = http.Client();

  Future<ApiResponse> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    final headers = {'content-type': 'application/json'};
    try {
      var response = await client.get(url, headers: headers);
      return ApiResponse(
        response.statusCode,
        json.decode(response.body),
      );
    } catch (e) {
      print('Error during GET request: $e');
      throw Exception('Failed to make GET request');
    }
  }

  Future<ApiResponse> post(String api, dynamic data) async {
    var url = Uri.parse(baseUrl + api);
    final headers = {'content-type': 'application/json'};
    var payload = jsonEncode(data);
    try {
      var response = await client.post(url, body: payload, headers: headers);
      return ApiResponse(
        response.statusCode,
        json.decode(response.body),
      );
    } catch (e) {
      print('Error during POST request: $e');
      throw Exception('Failed to make POST request');
    }
  }

  Future<ApiResponse> put(String api, dynamic data) async {
    var url = Uri.parse(baseUrl + api);
    final headers = {'content-type': 'application/json'};
    var payload = jsonEncode(data);
    try {
      var response = await client.put(url, body: payload, headers: headers);
      return ApiResponse(
        response.statusCode,
        json.decode(response.body),
      );
    } catch (e) {
      print('Error during PUT request: $e');
      throw Exception('Failed to make PUT request');
    }
  }

  Future<ApiResponse> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    final headers = {'content-type': 'application/json'};
    try {
      var response = await client.delete(url, headers: headers);
      return ApiResponse(
        response.statusCode,
        json.decode(response.body),
      );
    } catch (e) {
      print('Error during DELETE request: $e');
      throw Exception('Failed to make DELETE request');
    }
  }
}
