import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  HttpClient.internal();
  static final HttpClient _instance = HttpClient.internal();
  factory HttpClient() => _instance;
  static HttpClient get instance => _instance;

  Future<http.Response> postRequest(
      {required String endPoint,
      required Map<String, String> header,
      required Map<dynamic, dynamic> data}) {
    String url = endPoint;
    return http.post(Uri.parse(url),
        headers: header,
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
  }

  Future<http.Response> getRequest(
      {required String endPoint, required Map<String, String> header}) {
    String url = endPoint;
    return http.get(Uri.parse(url), headers: header);
  }
}
