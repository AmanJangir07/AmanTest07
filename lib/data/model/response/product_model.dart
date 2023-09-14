import 'category.dart';

class ProductSpecifications {
  final double? height;
  final double? weight;
  final double? length;
  final double? width;
  final model;
  final manufacturer;
  final dimensionUnitOfMeasure;
  final weightUnitOfMeasure;
  ProductSpecifications({
    this.height,
    this.weight,
    this.length,
    this.width,
    this.model,
    this.manufacturer,
    this.dimensionUnitOfMeasure,
    this.weightUnitOfMeasure,
  });
  factory ProductSpecifications.fromJson(Map<String, dynamic> json) {
    return ProductSpecifications(
      height: json['height'] ?? 0.0,
      weight: json['weight'] ?? 0.0,
      length: json['length'] ?? 0.0,
      width: json['width'] ?? 0.0,
      model: json['model'],
      manufacturer: json['manufacturer'],
      dimensionUnitOfMeasure: json['dimensionUnitOfMeasure'],
      weightUnitOfMeasure: json['weightUnitOfMeasure'],
    );
  }
}

class ProductDescription {
  final int? id;
  final String? language;
  final String? name;
  final String? description;
  final String? friendlyUrl;
  final String? keyWords;
  final String? highlights;
  final String? metaDescription;
  final String? title;

  ProductDescription({
    this.id,
    this.language,
    this.name,
    this.description,
    this.friendlyUrl,
    this.keyWords,
    this.highlights,
    this.metaDescription,
    this.title,
  });
  factory ProductDescription.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? ProductDescription()
        : ProductDescription(
            id: json['id'],
            language: json['language'],
            name: json['name'],
            description: json['description'],
            friendlyUrl: json['friendlyUrl'],
            keyWords: json['keyWords'],
            highlights: json['highlights'],
            metaDescription: json['metaDescription'],
            title: json['title'],
          );
  }
}

class ProductPriceDescription {
  final int? id;
  final String? language;
  final String? name;
  final description;
  final friendlyUrl;
  final keyWords;
  final highlights;
  final metaDescription;
  final title;
  final priceAppender;
  ProductPriceDescription({
    this.id,
    this.language,
    this.name,
    this.description,
    this.friendlyUrl,
    this.keyWords,
    this.highlights,
    this.metaDescription,
    this.title,
    this.priceAppender,
  });

  factory ProductPriceDescription.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? ProductPriceDescription()
        : ProductPriceDescription(
            id: json['id'],
            language: json['language'],
            name: json['name'],
            description: json['description'],
            friendlyUrl: json['friendlyUrl'],
            keyWords: json['keyWords'],
            highlights: json['highlights'],
            metaDescription: json['metaDescription'],
            title: json['title'],
            priceAppender: json['priceAppender'],
          );
  }
}

class ProductPrice {
  final int? id;
  final String? originalPrice;
  final String? finalPrice;
  final double? originalPriceDecimal;
  final double? finalPriceDecimal;
  final bool? discounted;
  final String? discountValue;
  final String? discountPercent;
  final ProductPriceDescription? description;
  ProductPrice({
    this.id,
    this.originalPrice,
    this.finalPrice,
    this.originalPriceDecimal,
    this.finalPriceDecimal,
    this.discounted,
    this.discountValue,
    this.discountPercent,
    this.description,
  });
  factory ProductPrice.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? ProductPrice()
        : ProductPrice(
            id: json['id'],
            originalPrice: json['originalPrice'],
            finalPrice: json['finalPrice'],
            originalPriceDecimal: json['originalPriceDecimal'],
            finalPriceDecimal: json['finalPriceDecimal'],
            discounted: json['discounted'],
            discountValue: json['discountValue'],
            discountPercent: json['discountPercent'],
            description: ProductPriceDescription.fromJson(json['description']),
          );
  }
}

class ProductImage {
  final int? id;
  final String? imageName;
  final String? imageUrl;
  final externalUrl;
  final videoUrl;
  final int? imageType;
  final bool? defaultImage;
  ProductImage({
    this.id,
    this.imageName,
    this.imageUrl,
    this.externalUrl,
    this.videoUrl,
    this.imageType,
    this.defaultImage,
  });
  factory ProductImage.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? ProductImage()
        : ProductImage(
            id: json['id'],
            imageName: json['imageName'],
            imageUrl: json['imageUrl'],
            externalUrl: json['externalUrl'],
            videoUrl: json['videoUrl'],
            imageType: json['imageType'],
            defaultImage: json['defaultImage'],
          );
  }
}

class ManufacturerDescription {
  final int? id;
  final language;
  final String? name;
  final description;
  final friendlyUrl;
  final keyWords;
  final highlights;
  final metaDescription;
  final title;
  ManufacturerDescription({
    this.id,
    this.language,
    this.name,
    this.description,
    this.friendlyUrl,
    this.keyWords,
    this.highlights,
    this.metaDescription,
    this.title,
  });
  factory ManufacturerDescription.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? ManufacturerDescription()
        : ManufacturerDescription(
            id: json['id'],
            language: json['language'],
            name: json['name'],
            description: json['description'],
            friendlyUrl: json['friendlyUrl'],
            keyWords: json['friendlyUrl'],
            highlights: json['friendlyUrl'],
            metaDescription: json['friendlyUrl'],
            title: json['friendlyUrl'],
          );
  }
}

class Manufacturer {
  final int? id;
  final String? code;
  final int? order;
  final ManufacturerDescription? description;
  Manufacturer({
    this.id,
    this.code,
    this.order,
    this.description,
  });
  factory Manufacturer.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? Manufacturer()
        : Manufacturer(
            id: json['id'],
            code: json['code'],
            order: json['order'],
            description: ManufacturerDescription.fromJson(json['description']),
          );
  }
}

class Type {
  final int? id;
  final String? code;
  final String? name;
  final bool? allowAddToCart;
  Type({
    this.id,
    this.code,
    this.name,
    this.allowAddToCart,
  });
  factory Type.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? Type()
        : Type(
            id: json['id'],
            code: json['code'],
            name: json['name'],
            allowAddToCart: json['allowAddToCart'],
          );
  }
}

class CartItemattribute {
  int? _id;
  String? _language;
  ProductOption? _option;
  OptionValue? _optionValue;
  CartItemattribute(
      {int? id,
      String? language,
      ProductOption? option,
      OptionValue? optionValue}) {
    this._id = id;
    this._language = language;
    this._option = option;
    this._optionValue = optionValue;
  }

  int? get id => _id;
  String? get language => _language;
  ProductOption? get productOption => _option;
  OptionValue? get optionValue => _optionValue;
  factory CartItemattribute.fromJson(Map<String, dynamic> inputJson) {
    return inputJson == null
        ? CartItemattribute()
        : CartItemattribute(
            id: inputJson['id'],
            language: inputJson['language'],
            option: ProductOption.fromJson(
              inputJson['option'],
            ),
            optionValue: OptionValue.fromJson(
              inputJson['optionValue'],
            ));
  }
}

class ProductOption {
  int? _id;
  String? _code;
  String? _type;
  bool? _readOnly;
  String? _name;
  String? _lang;
  List<OptionValue>? _optionValues;
  ProductOption(
      {int? id,
      String? code,
      String? type,
      bool? readOnly,
      String? name,
      String? lang,
      List<OptionValue>? optionValues}) {
    this._id = id;
    this._code = code;
    this._type = type;
    this._readOnly = readOnly;
    this._name = name;
    this._lang = lang;
    this._optionValues = optionValues;
  }

  int? get id => _id;
  String? get code => _code;
  String? get type => _type;
  bool? get readOnly => _readOnly;
  String? get name => _name;
  String? get lang => _lang;
  List<OptionValue>? get optionValues => _optionValues;

  factory ProductOption.fromJson(Map<String, dynamic>? inputJson) {
    return inputJson == null
        ? ProductOption()
        : ProductOption(
            id: inputJson['id'],
            code: inputJson['code'],
            type: inputJson['type'],
            readOnly: inputJson['readOnly'],
            name: inputJson['name'],
            lang: inputJson['lang'],
            optionValues: inputJson['optionValues'] == null
                ? null
                : (inputJson['optionValues'] as List<dynamic>)
                    .map((optionValue) => OptionValue.fromJson(optionValue))
                    .toList(),
          );
  }
}

class OptionValue {
  int? _id;
  String? _code;
  String? _name;
  bool? _defaultValue;
  int? _sortOrder;
  dynamic _image;
  int? _order;
  double? _price;
  Description? _description;
  OptionValue(
      {int? id,
      String? code,
      String? name,
      bool? defaultValue,
      int? sortOrder,
      dynamic image,
      int? order,
      double? price,
      Description? description}) {
    this._id = id;
    this._code = code;
    this._name = name;
    this._defaultValue = defaultValue;
    this._sortOrder = sortOrder;
    this._image = image;
    this._order = order;
    this._price = price;
    this._description = description;
  }
  int? get id => _id;
  String? get code => _code;
  String? get name => _name;
  bool? get defaultValue => _defaultValue;
  int? get sortOrder => _sortOrder;
  dynamic get image => _image;
  int? get order => _order;
  double? get price => _price;
  Description? get description => _description;

  factory OptionValue.fromJson(Map<String, dynamic>? inputJson) {
    return inputJson == null
        ? OptionValue()
        : OptionValue(
            id: inputJson['id'],
            code: inputJson['code'],
            name: inputJson['name'],
            defaultValue: inputJson['defaultValue'],
            sortOrder: inputJson['sortOrder'],
            image: inputJson['image'],
            order: inputJson['order'],
            price: inputJson['price'],
            description: inputJson['description'] == null
                ? null
                : Description.fromJson(inputJson['description']));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['code'] = this._code;
    data['description'] = this._description;
    return data;
  }
}

class Product {
  final int? id;
  final price;
  int? quantity;
  final String? sku;
  final bool? productShipeable;
  final bool? preOrder;
  final bool? productVirtual;
  final int? quantityOrderMaximum;
  final int? quantityOrderMinimum;
  final bool? productIsFree;
  final bool? available;
  final bool? visible;
  final ProductSpecifications? productSpecifications;
  final double? rating;
  final int? ratingCount;
  final int? sortOrder;
  final String? dateAvailable;
  final String? refSku;
  final condition;
  final String? creationDate;
  final int? rentalDuration;
  final int? rentalPeriod;
  final rentalStatus;
  final ProductDescription? description;
  final ProductPrice? productPrice;
  final String? finalPrice;
  final String? originalPrice;
  final bool? discounted;
  final ProductImage? image;
  final List<ProductImage>? images;
  final Manufacturer? manufacturer;
  final attributes;
  List<ProductOption>? options;
  final List<Category>? categories;
  final Type? type;
  final bool? canBePurchased;
  final owner;
  final subTotal;
  final displaySubTotal;
  String? _addedBy;
  String _discountType = 'percent';
  String _tax = '10';
  String _taxType = 'percent';
  List<CartItemattribute>? cartItemattributes;

  //Varient Added
  final List<ProductColors> _colors = [
    ProductColors(code: '#caca00', name: 'cyne'),
    ProductColors(code: '#228b8b', name: 'green')
  ];
  List<ChoiceOptions> _choiceOptions = [];
  List<Variation> _variation = [];
  Product(
      {this.id,
      this.price,
      this.quantity,
      this.sku,
      this.productShipeable,
      this.preOrder,
      this.productVirtual,
      this.quantityOrderMaximum,
      this.quantityOrderMinimum,
      this.productIsFree,
      this.available,
      this.visible,
      this.productSpecifications,
      this.rating,
      this.ratingCount,
      this.sortOrder,
      this.dateAvailable,
      this.refSku,
      this.condition,
      this.creationDate,
      this.rentalDuration,
      this.rentalPeriod,
      this.rentalStatus,
      this.description,
      this.productPrice,
      this.finalPrice,
      this.originalPrice,
      this.discounted,
      this.image,
      this.images,
      this.manufacturer,
      this.attributes,
      this.options,
      this.categories,
      this.type,
      this.canBePurchased,
      this.owner,
      this.subTotal,
      this.displaySubTotal,
      this.cartItemattributes});

  factory Product.fromJson(Map<String, dynamic>? json) {
    // log('produt ${json['productPrice']}');
    return json == null
        ? Product()
        : Product(
            id: json['id'],
            price: json['price'],
            quantity: json['quantity'],
            sku: json['sku'],
            productShipeable: json['productShipeable'],
            preOrder: json['preOrder'],
            productVirtual: json['productVirtual'],
            quantityOrderMaximum: json['quantityOrderMaximum'],
            quantityOrderMinimum: json['quantityOrderMinimum'],
            productIsFree: json['productIsFree'],
            available: json['available'],
            visible: json['visible'],
            productSpecifications: ProductSpecifications.fromJson(
                json['productSpecifications'] as Map<String, dynamic>),
            rating: json['rating'],
            ratingCount: json['ratingCount'],
            sortOrder: json['sortOrder'],
            dateAvailable: json['dateAvailable'],
            refSku: json['refSku'],
            condition: json['condition'],
            creationDate: json['creationDate'],
            rentalDuration: json['rentalDuration'],
            rentalPeriod: json['rentalPeriod'],
            rentalStatus: json['rentalStatus'],
            description: ProductDescription.fromJson(json['description']),
            productPrice: ProductPrice.fromJson(json['productPrice']),
            finalPrice: json['finalPrice'],
            originalPrice: json['originalPrice'],
            discounted: json['discounted'],
            image: ProductImage?.fromJson(json['image']),
            images: json['images'] == null
                ? null
                : (json['images'] as List<dynamic>)
                    .map((image) => ProductImage.fromJson(image))
                    .toList(),
            manufacturer: Manufacturer.fromJson(json['manufacturer']),
            attributes: json['attributes'],
            options: json['options'] == null
                ? null
                : (json['options'] as List<dynamic>)
                    .map((e) => ProductOption.fromJson(e))
                    .toList(),
            categories: json['categories'] == null
                ? null
                : (json['categories'] as List<dynamic>)
                    .map((category) => Category.fromJson(category))
                    .toList(),
            type: Type.fromJson(json['type']),
            canBePurchased: json['canBePurchased'],
            owner: json['owner'],
            subTotal: json['subTotal'],
            displaySubTotal: json['displaySubTotal'],
            cartItemattributes: json['cartItemattributes'] == null
                ? null
                : (json['cartItemattributes'] as List<dynamic>)
                    .map((e) => CartItemattribute.fromJson(e))
                    .toList());
  }
  List<ChoiceOptions> get choiceOptions => _choiceOptions;
  List<Variation> get variation => _variation;
  String? get addedBy => _addedBy;
  String get discountType => _discountType;
  String get tax => _tax;
  String get taxType => _taxType;
  List<ProductColors> get colors => _colors;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartItemattributes'] = this.cartItemattributes;
    return data;
  }
}

class ProductColors {
  String? _name;
  String? _code;

  ProductColors({String? name, String? code}) {
    this._name = name;
    this._code = code;
  }

  String? get name => _name;
  String? get code => _code;

  factory ProductColors.fromJson(Map<String, dynamic> json) {
    return json == null
        ? ProductColors()
        : ProductColors(name: json['name'], code: json['code']);
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this._name;
//     data['code'] = this._code;
//     return data;
//   }
}

class ChoiceOptions {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOptions({String? name, String? title, List<String>? options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class Variation {
  String? _type;
  String? _price;
  String? _sku;
  String? _qty;

  Variation({String? type, String? price, String? sku, String? qty}) {
    this._type = type;
    this._price = price;
    this._sku = sku;
    this._qty = qty;
  }

  String? get type => _type;
  String? get price => _price;
  String? get sku => _sku;
  String? get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'];
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['price'] = this._price;
    data['sku'] = this._sku;
    data['qty'] = this._qty;
    return data;
  }
}

class ProductVariantPrice {
  int? _id;
  String? _originalPrice;
  String? _finalPrice;
  bool? _discounted;
  String? _discountValue;
  String? _discountPercent;
  int? _productUnitQuantity;
  int? _productUnitCode;
  String? _description;
  ProductVariantPrice({
    int? id,
    String? originalPrice,
    String? finalPrice,
    bool? discounted,
    String? discountValue,
    String? discountPercent,
    int? productUnitQuantity,
    int? productUnitCode,
    String? description,
  }) {
    this._id = id;
    this._originalPrice = originalPrice;
    this._finalPrice = finalPrice;
    this._discounted = discounted;
    this._discountValue = discountValue;
    this._discountPercent = discountPercent;
    this._productUnitQuantity = productUnitQuantity;
    this._productUnitCode = productUnitCode;
    this._description = description;
  }

  int? get id => _id;
  String? get originalPrice => _originalPrice;
  String? get finalPrice => _finalPrice;
  bool? get discounted => _discounted;
  String? get discountValue => _discountValue;
  String? get discountPercent => _discountPercent;
  int? get productUnitQuantity => _productUnitQuantity;
  int? get productUnitCode => _productUnitCode;
  String? get description => _description;

  factory ProductVariantPrice.fromJson(Map<String, dynamic>? inputJson) {
    return inputJson == null
        ? ProductVariantPrice()
        : ProductVariantPrice(
            id: inputJson['id'],
            originalPrice: inputJson['originalPrice'],
            finalPrice: inputJson['finalPrice'],
            discounted: inputJson['discounted'],
            discountValue: inputJson['discountValue'],
            discountPercent: inputJson['discountPercent'],
            productUnitQuantity: inputJson['productUnitQuantity'],
            productUnitCode: inputJson['productUnitCode'],
            description: inputJson['description'],
          );
  }
}

class ProductGroup {
  ProductGroup({
    this.code,
    this.active,
  });

  String? code;
  bool? active;

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        code: json["code"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "active": active,
      };
}

class ProductGroupValue {
  ProductGroupValue({
    this.totalPages,
    this.number,
    this.recordsTotal,
    this.recordsFiltered,
    this.products,
  });

  int? totalPages;
  int? number;
  int? recordsTotal;
  int? recordsFiltered;
  List<Product>? products;

  factory ProductGroupValue.fromJson(Map<String, dynamic> json) =>
      ProductGroupValue(
        totalPages: json["totalPages"],
        number: json["number"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "number": number,
        "recordsTotal": recordsTotal,
        "recordsFiltered": recordsFiltered,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
