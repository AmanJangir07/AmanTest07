class CheckoutDefinationModel {
  int? _id;
  int? get id => this._id;
  set id(int? value) => this._id = value;
  CheckoutDefinationModel({int? id}) {
    this._id = id;
  }

  factory CheckoutDefinationModel.fromJson(Map<String, dynamic> json) {
    return CheckoutDefinationModel(id: json['id']);
  }
}
