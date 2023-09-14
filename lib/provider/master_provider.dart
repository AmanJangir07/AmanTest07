import 'package:flutter/material.dart';
import 'package:shopiana/data/model/body/country_master_model.dart';
import 'package:shopiana/data/model/body/state_master_model.dart';
import 'package:shopiana/data/model/response/master_item_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/master_repo.dart';

class MasterProvider extends ChangeNotifier {
  final MasterRepo? masterRepo;
  final AuthRepo? authRepo;

  MasterProvider({required this.masterRepo, required this.authRepo});

  List<CountryMasterModel> _countries = [];
  List<StateMasterModel> _states = [];
  MasterItem? masterItem;
  MasterItem? get getMasterItem => this.masterItem;

  set setMasterItem(MasterItem masterItem) => this.masterItem = masterItem;
  List<CountryMasterModel> get countries => this._countries;

  set countries(List<CountryMasterModel> value) => this._countries = value;

  get states => this._states;

  set states(value) => this._states = value;

  Future<void> fetchCountries() async {
    try {
      _countries = await masterRepo!.getCountries();
      print("countries" + _countries.toString());
    } catch (e) {
      rethrow;
    }

    notifyListeners();
  }

  Future<List<StateMasterModel>> fetchAndGetStates(String? countryCode) async {
    try {
      return await masterRepo!.getStates(countryCode);
    } catch (e) {
      rethrow;
    }

    // notifyListeners();
  }

  Future<void> retrieveMasterItem(String itemKey) async {
    final token = authRepo!.getUserToken();

    try {
      masterItem = await masterRepo!.getMasterItem(itemKey, token);
    } on Exception catch (e) {}
    notifyListeners();
  }
}
