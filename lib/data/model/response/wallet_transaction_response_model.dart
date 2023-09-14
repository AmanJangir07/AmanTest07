class WalletTransactionList {
  WalletTransactionList({
    this.number,
    this.readableWalletTransactions,
    this.recordsFiltered,
    this.recordsTotal,
    this.totalPages,
  });

  int? number;
  List<ReadableWalletTransaction>? readableWalletTransactions;
  int? recordsFiltered;
  int? recordsTotal;
  int? totalPages;

  factory WalletTransactionList.fromJson(Map<String, dynamic> json) =>
      WalletTransactionList(
        number: json["number"],
        readableWalletTransactions: List<ReadableWalletTransaction>.from(
            json["readableWalletTransactions"]
                .map((x) => ReadableWalletTransaction.fromJson(x))),
        recordsFiltered: json["recordsFiltered"],
        recordsTotal: json["recordsTotal"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "readableWalletTransactions": List<dynamic>.from(
            readableWalletTransactions!.map((x) => x.toJson())),
        "recordsFiltered": recordsFiltered,
        "recordsTotal": recordsTotal,
        "totalPages": totalPages,
      };
}

class ReadableWalletTransaction {
  ReadableWalletTransaction({
    this.itemCode,
    this.itemImage,
    this.itemName,
    this.paymentMode,
    this.point,
    this.status,
    this.transactionDate,
    this.transactionNumber,
    this.transactionType,
  });

  String? itemCode;
  String? itemImage;
  String? itemName;
  String? paymentMode;
  int? point;
  String? status;
  DateTime? transactionDate;
  String? transactionNumber;
  String? transactionType;

  factory ReadableWalletTransaction.fromJson(Map<String, dynamic> json) =>
      ReadableWalletTransaction(
        itemCode: json["itemCode"],
        itemImage: json["itemImage"],
        itemName: json["itemName"],
        paymentMode: json["paymentMode"],
        point: json["point"],
        status: json["status"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        transactionNumber: json["transactionNumber"],
        transactionType: json["transactionType"],
      );

  Map<String, dynamic> toJson() => {
        "itemCode": itemCode,
        "itemImage": itemImage,
        "itemName": itemName,
        "paymentMode": paymentMode,
        "point": point,
        "status": status,
        "transactionDate": transactionDate!.toIso8601String(),
        "transactionNumber": transactionNumber,
        "transactionType": transactionType,
      };
}
