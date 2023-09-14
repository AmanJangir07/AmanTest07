import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/model/body/country_master_model.dart';
import 'package:shopiana/data/model/body/state_master_model.dart';
import 'package:shopiana/data/model/response/master_item_model.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class MasterRepo {
  final ApiBaseHelper? apiBaseHelper;
  MasterRepo({required this.apiBaseHelper});

  Future<List<CountryMasterModel>> getCountries() async {
    String url = API.MASTER_COUNTRY;
    final response = await apiBaseHelper!.get(url: url);
    List<CountryMasterModel> countries = [];
    List<dynamic>? extractedData = response as List<dynamic>?;
    if (extractedData != null) {
      extractedData.forEach((element) {
        countries.add(CountryMasterModel.fromJson(element));
      });
    }

    return countries;
  }

  Future<List<StateMasterModel>> getStates(String? countryCode) async {
    String url = API.masterStates(countryCode);
    final response = await apiBaseHelper!.get(url: url);
    List<StateMasterModel> states = [];
    List<dynamic>? extractedData = response as List<dynamic>?;
    if (extractedData != null) {
      extractedData.forEach((element) {
        states.add(StateMasterModel.fromJson(element));
      });
    }
    return states;
  }

  Future<MasterItem> getMasterItem(String itemKey, String token) async {
    final url = API.getMasterItem(itemKey);
    final response = await apiBaseHelper!.get(url: url, token: token);

    MasterItem masterItem = MasterItem.fromJson(response);

    return masterItem;
  }
}
