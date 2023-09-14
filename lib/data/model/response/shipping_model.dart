class ShippingTotal {
  ShippingTotal({
    this.subTotal,
    this.taxTotal,
    this.total,
    this.totals,
  });

  double? subTotal;
  double? taxTotal;
  double? total;
  List<Total>? totals;

  factory ShippingTotal.fromJson(Map<String, dynamic> json) => ShippingTotal(
        subTotal: json["subTotal"],
        taxTotal: json["taxTotal"],
        total: json["total"],
        totals: List<Total>.from(json["totals"].map((x) => Total.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "taxTotal": taxTotal,
        "total": total,
        "totals": List<dynamic>.from(totals!.map((x) => x.toJson())),
      };
}

class Total {
  Total({
    this.code,
    this.discounted,
    this.displayValue,
    this.id,
    this.module,
    this.order,
    this.text,
    this.title,
    this.total,
    this.value,
  });

  String? code;
  bool? discounted;
  String? displayValue;
  int? id;
  String? module;
  int? order;
  String? text;
  String? title;
  String? total;
  double? value;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        code: json["code"],
        discounted: json["discounted"],
        displayValue: json["displayValue"],
        id: json["id"],
        module: json["module"],
        order: json["order"],
        text: json["text"],
        title: json["title"],
        total: json["total"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "discounted": discounted,
        "displayValue": displayValue,
        "id": id,
        "module": module,
        "order": order,
        "text": text,
        "title": title,
        "total": total,
        "value": value,
      };
}
