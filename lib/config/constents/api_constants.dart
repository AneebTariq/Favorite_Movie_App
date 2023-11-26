import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:movie_app/config/constents/exceptions.dart';

class ApiConstants {
  static String baseUrl = "https://api.themoviedb.org/3/discover/";

  static String movies = "${baseUrl}movie";

  ////Headers////

  static Map<String, String> getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Map<String, String> getRequestHeadersToken(String token) {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
  }

  static Exceptions apiExceptions(Response response) {
    if (response.statusCode == 401) {
      return UnauthorizedAccess();
    } else {
      return CommonException('${response.statusCode} : ${response.statusCode}');
    }
  }
}
