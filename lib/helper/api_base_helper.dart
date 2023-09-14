import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/interceptor.dart';

class ApiBaseHelper {
  static final client = InterceptedClient.build(
      interceptors: [AuthorizationInterceptor()],
      retryPolicy: ExpiredTokenRetryPolicy());
  Future<dynamic> get({required String url, String? token}) async {
    var responseJson;
    try {
      final header = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response =
          await client.get(Uri.parse(API.BASE_URL + url), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete({required String url, String? token}) async {
    log("apiBaseHelper: delete method");
    var responseJson;
    try {
      final header = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response =
          await client.delete(Uri.parse(API.BASE_URL + url), headers: header);
      responseJson = _returnResponse(response);
      log("apiBaseHelper: delete response" + responseJson.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (error) {
      throw Exception("Error" + error.toString());
    }
    return responseJson;
  }

  Future<dynamic> put(
    String url,
    Object body,
    String token,
  ) async {
    var responseJson;
    try {
      final header = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await client.put(Uri.parse(API.BASE_URL + url),
          headers: header, body: json.encode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, String? token,
      {BuildContext? context}) async {
    if (Constants.isDebugMode) {
      log("body:" + body.toString());
      log("token:" + token.toString());
    }
    var responseJson;
    try {
      final header = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await client.post(Uri.parse(API.BASE_URL + url),
          headers: header, body: json.encode(body));
      print("response" + response.toString());
      responseJson = _returnResponse(response, context: context);
    } on SocketException catch (error) {
      throw NoInternetException(400, "No Internet Connection");
      // print("Exception error:" + error.toString());
      // if (context != null) {
      //   var snackBar = const SnackBar(
      //     content: Text('No Internet Connection'),
      //   );
      //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }

      // throw FetchDataException('No Internet connection');
    } catch (e) {
      rethrow;
      // print("Error is :" + e.toString());
    }
    print("responseJson in post" + responseJson.toString());
    return responseJson;
  }

  Future<dynamic> patch({
    required String url,
    Object? body,
    String? token,
  }) async {
    log(body.toString());
    var responseJson;
    log(json.encode(body));
    try {
      final header = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await client.patch(Uri.parse(API.BASE_URL + url),
          headers: header, body: json.encode(body));

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response, {BuildContext? context}) {
    try {
      dynamic responseBody = response.body;
      print("response.body" + response.body.toString());
      if (responseBody.isEmpty) {
        responseBody = "{}";
      }
      // log("apiBaseHelper: _returnResponse method");
      log(response.statusCode.toString());
      // log(response.body.toString());
      switch (response.statusCode) {
        case 200:
          var responseJson = json.decode(responseBody);
          log("200 response soon" + responseJson.toString());
          return responseJson;
        case 201:
          var responseJson = json.decode(responseBody);
          return responseJson;
        case 400:
          throw BadRequestException(response.statusCode, response.body);
        case 403:
          throw UnauthorisedException(
              response.statusCode, response.body.toString());
        case 404:
          throw ResourceNotFoundException(
              response.statusCode, response.body.toString());
        // case 500:
        // return client.retryPolicy?.shouldAttemptRetryOnResponse(response);
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } on AppException catch (error) {
      rethrow;
      // if (Constants.isDebugMode) {
      //   log("Error is:" + error.toString());
      // }
      // String errorMessage;
      // switch (error.statusCode) {
      //   case 401:
      //     errorMessage = Strings.INVALID_PASSWORD;
      //     break;
      //   default:
      //     errorMessage = Strings.GENERAL_ERROR;
      // }
      // // log("Exception in returnresponse" + error.message.toString());
      // var snackBar = SnackBar(
      //   content: Text(errorMessage),
      // );
      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
