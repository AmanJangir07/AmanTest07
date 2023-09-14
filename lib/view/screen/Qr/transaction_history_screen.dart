import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/helper/date_converter.dart';
import 'package:shopiana/provider/wallet_provider.dart';
import 'package:shopiana/utill/images.dart';

class TransactionHistoryScreen extends StatelessWidget {
  Future<void> getWalletTransaction(BuildContext context) async {
    await Provider.of<WalletProvider>(context, listen: false)
        .getWalletTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Wallet History"),
      ),
      body: FutureBuilder(
        future: getWalletTransaction(context),
        builder: (ctx, groupSnapshot) {
          if (groupSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (groupSnapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          } else {
            return Consumer<WalletProvider>(builder: (context, wallet, _) {
              return Container(
                child: wallet.walletTransactionList!.readableWalletTransactions!
                            .length >
                        0
                    ? ListView.builder(
                        itemCount: wallet.walletTransactionList!
                            .readableWalletTransactions!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                            height: 70,
                                            width: 100,
                                            child: wallet
                                                        .walletTransactionList
                                                        ?.readableWalletTransactions?[
                                                            index]
                                                        .itemImage !=
                                                    null
                                                ? Image.network(
                                                    wallet
                                                        .walletTransactionList!
                                                        .readableWalletTransactions![
                                                            index]
                                                        .itemImage!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    Images.no_image,
                                                    fit: BoxFit.fill,
                                                  )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 170,
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  wallet
                                                          .walletTransactionList!
                                                          .readableWalletTransactions![
                                                              index]
                                                          .itemName ??
                                                      "",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                          Icons.bolt_rounded),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      child: Text(wallet
                                                              .walletTransactionList!
                                                              .readableWalletTransactions![
                                                                  index]
                                                              .point
                                                              .toString() +
                                                          " Points"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(wallet
                                                .walletTransactionList!
                                                .readableWalletTransactions![
                                                    index]
                                                .status ??
                                            ""),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      color: Colors.black12))),
                                          child: Column(children: [
                                            Text(
                                              wallet
                                                      .walletTransactionList!
                                                      .readableWalletTransactions![
                                                          index]
                                                      .transactionNumber ??
                                                  "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(Icons.update),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(wallet
                                                        .walletTransactionList!
                                                        .readableWalletTransactions![
                                                            index]
                                                        .transactionType ??
                                                    ""),
                                              ],
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        color:
                                                            Colors.black12))),
                                            alignment: Alignment.center,
                                            height: 80,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                wallet
                                                        .walletTransactionList!
                                                        .readableWalletTransactions![
                                                            index]
                                                        .paymentMode ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(DateConverter.formatDate(wallet
                                                  .walletTransactionList!
                                                  .readableWalletTransactions![
                                                      index]
                                                  .transactionDate!)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Text("No Transactions Found"),
                      ),
              );
            });
          }
        },
      ),
    );
  }
}
