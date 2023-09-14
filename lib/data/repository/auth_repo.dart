import 'package:flutter/material.dart';
import 'package:shopiana/data/model/body/otpData.dart';
import 'package:shopiana/data/model/body/register_model.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class AuthRepo {
  // ApiBaseHelper _helper = ApiBaseHelper();
  final SharedPreferences? sharedPreferences;
  final ApiBaseHelper? apiBaseHelper;
  AuthRepo({required this.sharedPreferences, required this.apiBaseHelper});

  Future<dynamic> login(String? username, String? password) async {
    String url = API.LOGIN;
    final data = {'username': username, 'password': password};

    final response = await apiBaseHelper!.post(url, data, '');
    return response;
  }

  Future<dynamic> signUp(RegisterModel registerModel) async {
    String url = API.SIGNUP;
    final response = await apiBaseHelper!.post(url, registerModel, '');
    return response;
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    await sharedPreferences!.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserId(int userId) async {
    await sharedPreferences!.setInt(AppConstants.USER_ID, userId);
  }

  String getUserToken() {
    return sharedPreferences!.getString(AppConstants.TOKEN) ?? "";
  }

  String getUserId() {
    return sharedPreferences!.getInt(AppConstants.USER_ID) as String? ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences!.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences!.remove(AppConstants.CART_LIST);
    sharedPreferences!.remove(AppConstants.CURRENCY);
    sharedPreferences!.remove(AppConstants.USER_ID);
    sharedPreferences!.remove(AppConstants.CART_CODE);
    return sharedPreferences!.remove(AppConstants.TOKEN);
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    await sharedPreferences!.setString(AppConstants.USER_PASSWORD, password);
    await sharedPreferences!.setString(AppConstants.USER_EMAIL, email);
  }

  String getUserEmail() {
    return sharedPreferences!.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences!.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences!.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences!.remove(AppConstants.USER_EMAIL);
  }

  Future<bool> clearCart() async {
    return await sharedPreferences!.remove(AppConstants.CART_CODE);
  }

  Future<void> generateResetOtpByMobileNumber(String? username) async {
    String url = API.generateResetOtp();
    var data = {'current': "", 'code': "test", 'otp': 0, 'userName': username};
    final response = await apiBaseHelper!.post(url, data, '');
    return response;
  }

  Future<bool?> validateIsUserExist(String? username) async {
    String url = API.validateIsUserExist(username);
    // var data = {'current': "", 'code': "test", 'otp': 0, 'userName': username};
    var response;
    response = await apiBaseHelper!.get(url: url, token: '');
    return response;
  }

  Future<bool> validateResetOtp(String? username, String? otp) async {
    String url = API.validateResetOtp();
    bool response;
    // var data = {'code': "test", 'otp': otp, 'userName': username};
    var data = {
      'current': "",
      'code': "test",
      'otp': otp,
      'userName': username
    };
    var tresponse = await apiBaseHelper!.post(url, data, '');
    if (tresponse != null) {
      response = true;
    } else {
      response = false;
    }
    return response;
  }

  Future<dynamic> resetUserPin({
    required String otp,
    required String pin,
    required String repeatPin,
    required String username,
  }) async {
    var response;

    String url = API.resetUserPin();
    var data = {
      "current": 'test',
      "otp": int.parse(otp),
      "password": pin,
      "repeatPassword": repeatPin,
      "username": username
    };
    var userToken = getUserToken();
    response = await apiBaseHelper!.post(url, data, '');
    return response;
  }

  // genreate otp
  Future<dynamic> generateOtp(OtpData otpData) async {
    String url = API.GENERATE_OTP;
    var response = await apiBaseHelper!.post(url, otpData, '');
    response = response as dynamic;
    return response;
  }

  // validate otp
  Future<dynamic> validateOtp(OtpData otpData) async {
    String url = API.VALIDATE_OTP;
    var response = await apiBaseHelper!.post(url, otpData, '');
    response = response as dynamic;
    return response;
  }
}
