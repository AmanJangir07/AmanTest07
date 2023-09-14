import 'package:shopiana/data/model/response/product_model.dart';

class Totals {
  final String? code;
  final bool? discounted;
  final int? id;
  final String? module;
  final int? order;
  final String? text;
  final String? title;
  final String? total;
  final double? value;
  Totals(
      {this.code,
      this.discounted,
      this.id,
      this.module,
      this.order,
      this.text,
      this.title,
      this.total,
      this.value});

  factory Totals.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? Totals()
        : Totals(
            code: json['code'],
            discounted: json[''],
            id: json['id'],
            module: json['module'],
            order: json['order'],
            text: json['text'],
            title: json['title'],
            total: json['total'],
            value: (json['value'] as num).toDouble(),
          );
  }
}

class CartModel {
  final String? code;
  final customer;
  final String? displaySubTotal;
  final String? displayTotal;

  final int? id;
  final String? language;
  final order;
  final List<Product>? products;
  final int? quantity;
  final subtotal;
  final double? total;
  final List<Totals>? totals;
  final String? promoCode;
  // final Packaging packaging;

  CartModel(
      {this.code,
      this.customer,
      this.displaySubTotal,
      this.displayTotal,
      this.id,
      this.language,
      this.order,
      this.products,
      this.quantity,
      this.subtotal,
      this.total,
      this.totals,
      this.promoCode
      // @required this.packaging
      });

  factory CartModel.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? CartModel()
        : CartModel(
            code: json['code'],
            customer: json['customer'],
            displaySubTotal: json['displaySubTotal'],
            displayTotal: json['displayTotal'],
            id: json['id'],
            language: json['language'],
            order: json['order'],
            products: (json['products'] as List<dynamic>)
                .map((product) => Product.fromJson(product))
                .toList(),
            quantity: json['quantity'],
            subtotal: json['subtotal'],
            total: json['total'],
            totals: (json['totals'] as List<dynamic>)
                .map((total) => Totals.fromJson(total))
                .toList(),
            promoCode: json['promoCode']);
  }
}

class CartQuantity {
  CartQuantity({
    this.product,
    this.quantity,
  });

  int? product;
  int? quantity;

  factory CartQuantity.fromJson(Map<String, dynamic> json) => CartQuantity(
        product: json["product"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
      };
}
