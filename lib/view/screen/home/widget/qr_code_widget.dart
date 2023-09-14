import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/persistable/qr_transaction_model.dart';
import 'package:shopiana/provider/wallet_provider.dart';
import 'package:shopiana/view/screen/Qr/transaction_history_screen.dart';

class QRCodeWidget extends StatefulWidget {
  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  bool isLoading = false;
  PersistentBottomSheetController? _controller;
  _scan() async {
    String value = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.QR);
    if (value == "-1") {
    } else {
      _dialogBuilder(context, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          width: 280,
          height: 70,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )),
              onPressed: () => _scan(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(Icons.qr_code_scanner),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "SCAN QR",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      )),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Container(
                          child: Icon(Icons.credit_card),
                        ),
                        Text(
                          "Redeem",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    )),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransactionHistoryScreen())),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Container(
                        child: Icon(Icons.wallet_giftcard_outlined),
                      ),
                      Text(
                        "History",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Icon(
      Icons.info_outline,
      size: 35,
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "For Point redemption, Kindly contact  to Administrator or Dealer"),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

void _dialogBuilder(BuildContext modalContext, String value) {
  showModalBottomSheet<void>(
    barrierColor: Colors.black87,
    context: modalContext,
    builder: (BuildContext dailogContext) {
      bool isLoading = false;
      QrTransaction qrTransaction = QrTransaction.fromJson(json.decode(value));
      return StatefulBuilder(
        builder: (context, setState) => Container(
          height: 600,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: TextButton(
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(dailogContext);
                              },
                            ),
                          ),
                          Container(
                            child: TextButton(
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.pop(dailogContext);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(children: [
                              Text(
                                "Qr Code : ",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                qrTransaction.code!,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Text(
                                "Product Name : ",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    qrTransaction.itemName!,
                                    maxLines: 3,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Text(
                                "Points : ",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                qrTransaction.point!.toString(),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(dailogContext).primaryColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        child: const Text('Submit'),
                        onPressed: () {
                          setState(() => isLoading = true);
                          createQrtransaction(qrTransaction, dailogContext);
                        },
                      ),
                    ),
                  ],
                ),
        ),
      );
    },
  );
}

void createQrtransaction(
    QrTransaction qrTransaction, BuildContext qrContext) async {
  await Provider.of<WalletProvider>(qrContext, listen: false)
      .createQrTransaction(qrTransaction: qrTransaction, context: qrContext);
  /*  if (Provider.of<WalletProvider>(qrContext, listen: false).appException !=
      null) {
    ScaffoldMessenger.of(qrContext).hideCurrentSnackBar();
    ScaffoldMessenger.of(qrContext).showSnackBar(SnackBar(
      content: Text(Provider.of<WalletProvider>(qrContext, listen: false)
          .appException
          .message),
      backgroundColor: Colors.red,
    ));
  } else {
    await Provider.of<WalletProvider>(qrContext, listen: false)
        .getWalletDetails();
    ScaffoldMessenger.of(qrContext).hideCurrentSnackBar();
    ScaffoldMessenger.of(qrContext).showSnackBar(SnackBar(
      content: Text("Reward points will be credit to your wallet shortly!"),
      backgroundColor: Colors.green,
    ));
  } */
  Navigator.of(qrContext).pop();
}
