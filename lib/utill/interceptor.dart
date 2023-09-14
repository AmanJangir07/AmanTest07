import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/di_container.dart';
import 'package:shopiana/utill/app_constants.dart';
import 'package:shopiana/view/screen/auth/auth_screen.dart';
import 'package:shopiana/view/screen/splash/splash_screen.dart';
import '../service/navigation_service.dart';

class AuthorizationInterceptor implements InterceptorContract {
  // We need to intercept request

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      print("interceptor request");
      print(data);
      // Fetching token from your locacl data
      // var token = await AppLocalData()
      //     .getStringPrefValue(key: AppConstants.userTokenKey);

      // Clear previous header and update it with updated token
      // data.headers.clear();

      // data.headers['authorization'] = 'Bearer ' + token!;
      // data.headers['content-type'] = 'application/json';
    } catch (e) {
      print(e);
    }

    return data;
  }

  // Currently we do not have any need to intercept response
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("interceptor response");
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  ExpiredTokenRetryPolicy();
  Future<void> clearSharedData(SharedPreferences sharedPreferences) async {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    sharedPreferences.remove(AppConstants.USER_ID);
    sharedPreferences.remove(AppConstants.CART_CODE);
    sharedPreferences.remove(AppConstants.TOKEN);
  }

  Future<bool> clearHomeAddress(SharedPreferences sharedPreferences) async {
    return sharedPreferences.remove(AppConstants.HOME_ADDRESS);
  }

  Future<bool> clearOfficeAddress(SharedPreferences sharedPreferences) async {
    return sharedPreferences.remove(AppConstants.OFFICE_ADDRESS);
  }

  Future<void> logoutInBackground() async {
    print("call logout in backend in inteceptor");
    // SharedPreferences sharedPreferences;
    final sharedPreferences = await SharedPreferences.getInstance();
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    clearSharedData(sharedPreferences);
    clearHomeAddress(sharedPreferences);
    clearOfficeAddress(sharedPreferences);
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthScreen()), (route) => true);
  }

  //Number of retry
  @override
  int maxRetryAttempts = 1;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    //This is where we need to update our token on 401 response
    print("shouldAttemptRetryOnResponse");
    print(response);
    if (response.statusCode == 401) {
      print("401 error");
      logoutInBackground();
      sl<NavigationService>().pushAndRemoveUntil(AuthScreen());
      return true;
    }
    return false;
  }
}
