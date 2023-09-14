import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/address_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';
import 'package:shopiana/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final SharedPreferences? sharedPreferences;
  final ApiBaseHelper? apiBaseHelper;
  ProfileRepo({required this.sharedPreferences, required this.apiBaseHelper});

  List<String> getAddressTypeList() {
    List<String> addressTypeList = [
      'Select Address type',
      'Home',
      'Office',
      'Other',
    ];
    return addressTypeList;
  }

  Future<UserProfile?> getUserInfo() async {
    String url = API.USER_PROFILE;
    // String url = '/api/v1/auth/customer/profile';
    UserProfile? userProfile;
    final response = await apiBaseHelper!.get(
        url: url, token: sharedPreferences!.getString(AppConstants.TOKEN));
    if (response != null) {
      userProfile = UserProfile.fromJson(response);
    }
    return userProfile;
  }

  Future<dynamic> updateUserInfo(UserProfile body) async {
    String url = API.UPDATE_PROFILE;
    var response;
    print(body.toString());
    print(body.groups![0].toJson());
    response = await apiBaseHelper!.patch(
        url: url,
        token: sharedPreferences!.getString(AppConstants.TOKEN),
        body: body);
    return response;
  }

  List<AddressModel> getAllAddress() {
    List<AddressModel> addressList = [
      AddressModel(
          id: 1,
          customerId: '1',
          contactPersonName: 'John Doe',
          addressType: 'Home',
          address: 'Dhaka, Bangladesh'),
    ];
    return addressList;
  }

  // for save home address
  Future<void> saveHomeAddress(String homeAddress) async {
    try {
      await sharedPreferences!.setString(AppConstants.HOME_ADDRESS, homeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getHomeAddress() {
    return sharedPreferences!.getString(AppConstants.HOME_ADDRESS) ?? "";
  }

  Future<bool> clearHomeAddress() async {
    return sharedPreferences!.remove(AppConstants.HOME_ADDRESS);
  }

  // for save office address
  Future<void> saveOfficeAddress(String officeAddress) async {
    try {
      await sharedPreferences!.setString(
          AppConstants.OFFICE_ADDRESS, officeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getOfficeAddress() {
    return sharedPreferences!.getString(AppConstants.OFFICE_ADDRESS) ?? "";
  }

  Future<bool> clearOfficeAddress() async {
    return sharedPreferences!.remove(AppConstants.OFFICE_ADDRESS);
  }

  void setGuestUserAddress(UserProfile guestUserAddress) {
    sharedPreferences!.setString(
        "guestUserAddress", jsonEncode(guestUserAddress));
  }

  UserProfile? getGuestUserAddress() {
    String? userAddress = sharedPreferences!.getString("guestUserAddress");
    UserProfile? userProfile;
    if (userAddress != null) {
      var userAddressDecoded = jsonDecode(userAddress) as Map<String, dynamic>;
      userProfile = UserProfile.fromJson(userAddressDecoded);
    }
    return userProfile;
  }
}
