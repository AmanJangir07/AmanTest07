import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/body/login_model.dart';
import 'package:shopiana/data/model/body/otpData.dart';
import 'package:shopiana/data/model/body/register_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/cart_repo.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/snackbar.dart';
import 'package:shopiana/utill/string_resources.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';

enum NotifierState { initial, loading, loaded }

class AuthProvider with ChangeNotifier {
  final AuthRepo? authRepo;
  final CartRepo? cartRepo;

  AuthProvider({required this.authRepo, required this.cartRepo});
  NotifierState _state = NotifierState.initial;

  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  AppException? _appException;
  AppException? get appException => _appException;
  void _setAppException(AppException appException) {
    _appException = appException;
    // notifyListeners();
  }

  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  bool _isUserExist = false;
  bool get isUserExist => _isUserExist;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isRemember => _isRemember;

  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  Future registration(RegisterModel register) async {
    var response = await authRepo!.signUp(register);

    if (response != null) {
      authRepo!.saveUserToken(response['token']);
      authRepo!.saveUserId(response['id']);
    }
  }

  Future login(LoginModel loginBody, BuildContext context) async {
    _setState(NotifierState.loading);
    try {
      final responseData =
          await authRepo!.login(loginBody.username, loginBody.password);
      if (responseData != null) {
        authRepo!.saveUserToken(responseData['token']);
        authRepo!.saveUserId(responseData['id']);
        await cartRepo!.mergeCart();
        showSuccessSnackbar(context, Strings.LOGGED_IN);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DashBoardScreen(),
            ),
            (route) => false);
      }
    } on AppException catch (e) {
      print("In exception login" + e.toString());
      _setAppException(e);
      showErrorSnackbar(context, e.message!);
    }

    _setState(NotifierState.loaded);
  }

  // for user Section
  String getUserToken() {
    return authRepo!.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo!.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo!.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo!.getUserEmail();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo!.getUserPassword();
  }

  Future<dynamic> validateUserIsExist(
      {BuildContext? context, String? userName}) async {
    try {
      var response = await authRepo!.validateIsUserExist(userName);
      if (response != null) {
        this._isUserExist = response;
        notifyListeners();
      }
      return response;
    } on AppException catch (e) {
      showErrorSnackbar(context!, e.message!);
    }
  }

  void generateResetOpt({BuildContext? context, String? userName}) async {
    try {
      await authRepo!.generateResetOtpByMobileNumber(userName);
    } on AppException catch (e) {
      showErrorSnackbar(context!, e.message!);
    }
  }

  Future<bool> validateResetOtp(
      {BuildContext? context, String? username, String? otp}) async {
    try {
      return await authRepo!.validateResetOtp(username, otp);
    } on AppException catch (e) {
      showErrorSnackbar(context!, e.message!);
      return false;
    }
  }

  Future<dynamic> resetUserPin({
    required String otp,
    required String pin,
    required String repeatPin,
    required String username,
  }) async {
    return await authRepo!.resetUserPin(
        otp: otp, pin: pin, repeatPin: repeatPin, username: username);
  }

  // genrate otp
  Future<dynamic> genrateOtp(
      {BuildContext? context, required String mobileNumber}) async {
    OtpData otpData = OtpData();
    otpData.otp = '0';
    otpData.code = 'test';
    otpData.requestType = Constants.SIGNUP;
    otpData.userName = mobileNumber;
    try {
      dynamic response = await authRepo!.generateOtp(otpData);
      return response;
    } on AppException catch (e) {
      showErrorSnackbar(context!, e.message!);
    }

    return;
  }

  // validate user otp
  validateOtp(
      {BuildContext? context, String? otp, String? mobileNumber}) async {
    OtpData otpData = OtpData();
    otpData.code = 'test';
    otpData.otp = otp;
    otpData.requestType = Constants.SIGNUP;
    otpData.userName = mobileNumber;

    try {
      var response = await authRepo!.validateOtp(otpData);
      return response;
    } on AppException catch (e) {
      showErrorSnackbar(context!, e.message!);
    }
  }

  checkIsUserExist(String userNumber) {}

  Future<void> changeToken() async {
    await authRepo!.saveUserToken(
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5NzgyOTE1OTA4IiwiYXVkIjoiYXBpIiwiZXhwIjoxNjcxNDQ1ODUzLCJpYXQiOjE2NzA4NDEwNTN9.ELXN26ySp493V1eKLnQKGLf2PsvyuOgOL0tOpX4vyWsXko8Tvx0JYoM-O6KAk8IfulmLHnRcilexfW1w_pKVWe");
  }
}
