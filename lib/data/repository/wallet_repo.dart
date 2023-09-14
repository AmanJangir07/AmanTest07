import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/model/response/wallet_detail_model.dart';
import 'package:shopiana/data/model/response/wallet_transaction_response_model.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class WalletRepo {
  final ApiBaseHelper? apiBaseHelper;
  final SharedPreferences? sharedPreferences;

  WalletRepo({this.apiBaseHelper, this.sharedPreferences});

  Future<void> createQrTransaction(
      {Object? transaction, String? token, required String url}) async {
    await apiBaseHelper!.post(url, transaction, token);
  }

  Future<WalletTransactionList> getWalletTransactionList(
      {required String url, String? token}) async {
    final response = await apiBaseHelper!.get(url: url, token: token);
    WalletTransactionList walletTransactionList =
        WalletTransactionList.fromJson(response);
    return walletTransactionList;
  }

  Future<WalletDetail> getWalletDetail({required String url, String? token}) async {
    final response = await apiBaseHelper!.get(url: url, token: token);
    WalletDetail walletDetail = WalletDetail.fromJson(response);
    return walletDetail;
  }
}
