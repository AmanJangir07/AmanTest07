import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/address_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/data/repository/profile_repo.dart';
import 'package:shopiana/helper/app_exception.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo? profileRepo;
  ProfileProvider({required this.profileRepo});

  List<String> _addressTypeList = [];
  List<String> get addressTypeList => _addressTypeList;

  String _addressType = '';
  String get addressType => _addressType;

  UserProfile? _userInfoModel;
  UserProfile? get userInfoModel => _userInfoModel;

  UserProfile? _guestInfo;
  UserProfile? get guestInfo => _guestInfo;

  bool _isAvailableProfile = false;
  bool get isAvailableProfile => _isAvailableProfile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AddressModel>? _addressList;
  List<AddressModel>? get addressList => _addressList;

  bool? _hasData;
  bool? get hasData => _hasData;

  bool _isHomeAddress = true;
  bool get isHomeAddress => _isHomeAddress;

  String? _addAddressErrorText;
  String? get addAddressErrorText => _addAddressErrorText;

  void setAddAddressErrorText(String? errorText) {
    _addAddressErrorText = errorText;
    notifyListeners();
  }

  void updateAddressCondition(bool value) {
    _isHomeAddress = value;
    notifyListeners();
  }

  bool _checkHomeAddress = false;
  bool get checkHomeAddress => _checkHomeAddress;

  bool _checkOfficeAddress = false;
  bool get checkOfficeAddress => _checkOfficeAddress;

  void setHomeAddress() {
    _checkHomeAddress = true;
    _checkOfficeAddress = false;
    notifyListeners();
  }

  void setOfficeAddress() {
    _checkHomeAddress = false;
    _checkOfficeAddress = true;
    notifyListeners();
  }

  updateCountryCode(String value) {
    _addressType = value;
    notifyListeners();
  }

  void initAddressList() {
    _addressList = [];
    profileRepo!
        .getAllAddress()
        .forEach((address) => _addressList!.add(address));
    notifyListeners();
  }

  void removeAddressById(int? id, int index) async {
    _isLoading = true;
    notifyListeners();
    _addressList!.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }

  Future<String> getUserInfo() async {
    _userInfoModel = null;
    try {
      final response = await profileRepo!.getUserInfo();
      _userInfoModel = response;
    } on AppException catch (e) {
      log(e.message!);
    }
    _isAvailableProfile = true;
    notifyListeners();
    return _userInfoModel!.id.toString();
  }

  void initAddressTypeList() async {
    if (_addressTypeList.length == 0) {
      _addressTypeList.clear();
      _addressTypeList.addAll(profileRepo!.getAddressTypeList());
      _addressType = profileRepo!.getAddressTypeList()[0];
      notifyListeners();
    }
  }

  void addAddress(AddressModel addressModel) async {
    _addressList!.add(addressModel);
    notifyListeners();
  }

  Future<dynamic> updateUserInfo(UserProfile updateUserProfile) async {
    _isLoading = true;
    notifyListeners();
    final response = await profileRepo!.updateUserInfo(updateUserProfile);
    if (response != null) {
      _userInfoModel = UserProfile.fromJson(response);
    }
    _isLoading = false;
    notifyListeners();
  }

  // save office and home address
  void saveHomeAddress(String homeAddress) {
    profileRepo!.saveHomeAddress(homeAddress).then((_) {
      notifyListeners();
    });
  }

  void saveOfficeAddress(String officeAddress) {
    profileRepo!.saveOfficeAddress(officeAddress).then((_) {
      notifyListeners();
    });
  }

  // save guest user info
  void saveGuestInfo(dynamic guestUserInfoParam, Function callback) {
    UserProfile userProfile = UserProfile.fromJson(guestUserInfoParam);
    if (userProfile != null) {
      _userInfoModel = userProfile;
      _guestInfo = userProfile;
      profileRepo!.setGuestUserAddress(userProfile);
      callback();
      notifyListeners();
    }
  }

  UserProfile? getSharePreferGuestUserAddress() {
    return this.profileRepo!.getGuestUserAddress();
  }

  // for home Address Section
  String getHomeAddress() {
    return profileRepo!.getHomeAddress();
  }

  Future<bool> clearHomeAddress() async {
    return await profileRepo!.clearHomeAddress();
  }

  // for office Address Section
  String getOfficeAddress() {
    return profileRepo!.getOfficeAddress();
  }

  Future<bool> clearOfficeAddress() async {
    return await profileRepo!.clearOfficeAddress();
  }
}
