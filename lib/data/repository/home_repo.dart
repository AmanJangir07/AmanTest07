import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/model/response/slider_model.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class HomeRepo {
  final SharedPreferences? sharedPreferences;
  final ApiBaseHelper? apiBaseHelper;
  HomeRepo({required this.sharedPreferences, required this.apiBaseHelper});

  Future<ImageSlider> getSlider({required String url, String? token}) async {
    final response = await apiBaseHelper!.get(url: url, token: token);
    ImageSlider slider = ImageSlider.fromJson(response);
    return slider;
  }
}
