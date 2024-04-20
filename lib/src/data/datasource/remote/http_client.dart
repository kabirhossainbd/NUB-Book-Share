import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:nub_book_sharing/src/data/datasource/remote/exception.dart';
import 'package:nub_book_sharing/src/utils/constants/m_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage = 'Connection lost due to internet connection';
  final int timeoutInSeconds = 30;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(MyKey.token);
    if(foundation.kDebugMode) {
      debugPrint('Token: $token');
    }
    updateHeader(token);
  }

  void updateHeader(String? token) {
    Map<String, String> header = {};
    header.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    _mainHeaders = header;
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response remoteResponse = await http.get(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(remoteResponse, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers, int? timeout}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response remoteResponse = await http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(remoteResponse, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response remoteResponse = await http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(remoteResponse, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response remoteResponse = await http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(remoteResponse, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }



  Response handleResponse(http.Response response, String uri) {
    dynamic dataBody;
    try {
      dataBody = jsonDecode(response.body);
    }catch(e) {
      rethrow;
    }
    Response remoteResponse = Response(
      body: dataBody ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(remoteResponse.statusCode != 200 && remoteResponse.body != null && remoteResponse.body is !String) {
      if(remoteResponse.body.toString().startsWith('{errors: [{code:')) {
        ErrorClass errorResponse = ErrorClass.fromJson(remoteResponse.body);
        remoteResponse = Response(statusCode: remoteResponse.statusCode, body: remoteResponse.body, statusText: errorResponse.errors![0].message);
      }else if(remoteResponse.body.toString().startsWith('{message')) {
        remoteResponse = Response(statusCode: remoteResponse.statusCode, body: remoteResponse.body, statusText: remoteResponse.body['message']);
      }
    }else if(remoteResponse.statusCode != 200 && remoteResponse.body == null) {
      remoteResponse = const Response(statusCode: 1005, statusText: noInternetMessage);
    }
    if(foundation.kDebugMode) {
      debugPrint('====> API Response: [${remoteResponse.statusCode}] $uri\n${remoteResponse.body}');
    }
    return remoteResponse;
  }
}
