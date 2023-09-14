class WalletDetail {
  WalletDetail({
    this.availablePoint,
    this.totalPoint,
    this.usedPoint,
    this.walletId,
  });

  int? availablePoint;
  int? totalPoint;
  int? usedPoint;
  int? walletId;

  factory WalletDetail.fromJson(Map<String, dynamic> json) => WalletDetail(
        availablePoint: json["availablePoint"],
        totalPoint: json["totalPoint"],
        usedPoint: json["usedPoint"],
        walletId: json["walletId"],
      );

  Map<String, dynamic> toJson() => {
        "availablePoint": availablePoint,
        "totalPoint": totalPoint,
        "usedPoint": usedPoint,
        "walletId": walletId,
      };
}
