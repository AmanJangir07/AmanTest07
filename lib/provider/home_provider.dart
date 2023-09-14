import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/slider_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/home_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/app_exception.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo? homeRepo;
  final AuthRepo? authRepo;
  HomeProvider({required this.homeRepo, required this.authRepo});

  ImageSlider? slider;
  get getSlider => this.slider;
  set setSlider(slider) => this.slider = slider;

  Future<void> getImageSlider() async {
    final url = API.getSlider();
    final token = authRepo!.getUserToken();
    try {
      slider = await homeRepo!.getSlider(url: url, token: token);
    } on AppException catch (e) {
      log(e.message!);
    }
    notifyListeners();
  }
}
