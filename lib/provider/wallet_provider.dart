import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/persistable/qr_transaction_model.dart';
import 'package:shopiana/data/model/response/wallet_detail_model.dart';
import 'package:shopiana/data/model/response/wallet_transaction_response_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/wallet_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/utill/snackbar.dart';

enum NotifierState { initial, loading, loaded }

class WalletProvider extends ChangeNotifier {
  final WalletRepo? walletRepo;
  final AuthRepo? authRepo;
  WalletProvider({this.walletRepo, this.authRepo});

  WalletTransactionList? walletTransactionList;
  WalletTransactionList? get getWalletTransactionList =>
      this.walletTransactionList;

  set setWalletTransactionList(WalletTransactionList walletTransactionList) =>
      this.walletTransactionList = walletTransactionList;

  WalletDetail? walletDetail;
  WalletDetail? get getWalletDetail => this.walletDetail;
  set setWalletDetail(WalletDetail walletDetail) =>
      this.walletDetail = walletDetail;

  AppException? _appException;
  AppException? get appException => _appException;
  void _setAppException(AppException appException) {
    _appException = appException;
    // notifyListeners();
  }

  Future<void> createQrTransaction(
      {QrTransaction? qrTransaction, required BuildContext context}) async {
    _appException = null;
    final token = authRepo!.getUserToken();
    final url = API.createQrTransaction();
    try {
      await walletRepo!.createQrTransaction(
          token: token, transaction: qrTransaction, url: url);
      await getWalletDetails();
      showSuccessSnackbar(
          context, "Reward points will be credit to your wallet shortly!");
    } on AppException catch (e) {
      showErrorSnackbar(context, e.message!);
    }
  }

  Future<void> getWalletTransaction() async {
    final url = API.getWalletTransactionList();
    final token = authRepo!.getUserToken();
    try {
      walletTransactionList =
          await walletRepo!.getWalletTransactionList(url: url, token: token);
    } on AppException catch (e) {
      print(e.message);
    }
    notifyListeners();
  }

  Future<void> getWalletDetails() async {
    final url = API.getWalletDetail();
    final token = authRepo!.getUserToken();
    try {
      walletDetail = await walletRepo!.getWalletDetail(url: url, token: token);
    } on AppException catch (e) {
      print(e.message);
    }
    notifyListeners();
  }
}
