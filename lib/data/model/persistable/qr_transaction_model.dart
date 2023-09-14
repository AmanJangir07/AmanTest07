class QrTransaction {
  QrTransaction({
    this.itemCode,
    this.itemName,
    this.orderId,
    this.point,
    this.code,
    this.walletId,
  });

  String? itemCode;
  String? itemName;
  int? orderId;
  int? point;
  String? code;
  int? walletId;

  factory QrTransaction.fromJson(Map<String, dynamic> json) => QrTransaction(
        itemCode: json["itemCode"],
        itemName: json["itemName"],
        orderId: json["orderId"],
        point: int.parse(json["point"]),
        code: json["code"],
        walletId: json["walletId"],
      );

  Map<String, dynamic> toJson() => {
        "itemCode": itemCode,
        "itemName": itemName,
        "orderId": orderId,
        "point": point,
        "code": code,
        "walletId": walletId,
      };
}
