import 'dart:developer';

class Category {
  int? _id;
  String? _code;
  int? _sortOrder;
  bool? _visible;
  bool? _featured;
  String? _lineage;
  int? _depth;
  dynamic _parent;
  int? _productCount;
  String? _store;
  CatImage? _image;
  List<dynamic>? _children;
  Description? _description;

  Category(
      {int? id,
      String? code,
      int? sortOrder,
      bool? visible,
      bool? featured,
      String? lineage,
      int? depth,
      dynamic parent,
      int? productCount,
      String? store,
      CatImage? image,
      List<dynamic>? children,
      Description? description}) {
    this._id = id;
    this._code = code;
    this._sortOrder = sortOrder;
    this._visible = visible;
    this._featured = featured;
    this._lineage = lineage;
    this._depth = depth;
    this._parent = parent;
    this._productCount = productCount;
    this._store = store;
    this._image = image;
    this._children = children;
    this._description = description;
  }

  int? get id => _id;
  String? get code => _code;
  int? get sortOrder => _sortOrder;
  bool? get visible => _visible;
  bool? get featured => _featured;
  String? get lineage => _lineage;
  int? get depth => _depth;
  String? get parent => _parent;
  int? get productCount => _productCount;
  String? get store => _store;
  CatImage? get image => _image;
  List<dynamic>? get children => _children;
  Description? get description => _description;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        code: json['code'],
        sortOrder: json['sortOrder'],
        visible: json['visible'],
        featured: json['featured'],
        lineage: json['lineage'],
        depth: json['depth'],
        parent: json['parent'],
        productCount: json['productCount'],
        store: json['store'],
        image: CatImage.fromJson(json['image']),
        children: json['children'],
        description: Description.fromJson(json['description']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['code'] = this.code;
    data['sortOrder'] = this.sortOrder;
    data['visible'] = this.visible;
    data['featured'] = this.featured;
    data['lineage'] = this.lineage;
    data['depth'] = this.depth;
    data['parent'] = this.parent;
    data['productCount'] = this.productCount;
    data['store'] = this.store;
    // data['image'] = this.image;
    data['children'] = this.children;
    // data['description'] = Description(this._description).toJson();
    return data;
  }
}

class Children {
  int? _id;
  String? _code;
  int? _sortOrder;
  bool? _visible;
  bool? _featured;
  String? _lineage;
  int? _depth;
  CatParent? _parent;
  Description? _description;
  int? _productCount;
  String? _store;
  CatImage? _image;
  Children? children;
  Children(
      {int? id,
      String? code,
      int? sortOrder,
      bool? visible,
      bool? featured,
      String? lineage,
      int? depth,
      CatParent? parent,
      Description? description,
      int? productCount,
      String? store,
      CatImage? image,
      Children? children}) {
    this._id = id;
    this._sortOrder = sortOrder;
    this._visible = visible;
    this._featured = featured;
    this._lineage = lineage;
    this._depth = depth;
    this._parent = parent;
    this._description = description;
    this._productCount = productCount;
    this._store = store;
    this._image = image;
    this.children = children;
  }
  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      id: json['id'],
      sortOrder: json['sortOrder'],
      visible: json['visible'],
      featured: json['featured'],
      lineage: json['lineage'],
      depth: json['depth'],
      parent: json['parent'],
      description: json['description'],
      productCount: json['productCount'],
      store: json['store'],
      image: json['image'],
      children: json['children'],
    );
  }
}

class CatParent {
  int? _id;
  String? _code;
  CatParent({int? id, String? code}) {
    this._id = id;
    this._code = code;
  }
  factory CatParent.fromJson(Map<String, dynamic> json) {
    return CatParent(id: json['id'], code: json['code']);
  }
}

class Description {
  int? _id;
  String? _language;
  String? _name;
  String? _description;
  String? _friendlyUrl;
  String? _keyWords;
  String? _highlights;
  String? _metaDescription;
  String? _title;

  Description(
      {int? id,
      String? language,
      String? name,
      String? description,
      String? friendlyUrl,
      String? keyWords,
      String? highlights,
      String? metaDescription,
      String? title}) {
    this._id = id;
    this._language = language;
    this._name = name;
    this._description = description;
    this._friendlyUrl = friendlyUrl;
    this._keyWords = keyWords;
    this._highlights = highlights;
    this._metaDescription = metaDescription;
    this._title = title;
  }
  int? get id => _id;
  String? get language => _language;
  String? get name => _name;
  String? get description => _description;
  String? get friendlyUrl => _friendlyUrl;
  String? get keyWords => _keyWords;
  String? get highlights => _highlights;
  String? get metaDescription => _metaDescription;
  String? get title => _title;

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['language'] = this._language;
    data['name'] = this._name;
    data['description'] = this._description;
    data['friendlyUrl'] = this._friendlyUrl;
    data['keyWords'] = this._keyWords;
    data['highlights'] = this._highlights;
    data['metaDescription'] = this._metaDescription;
    data['title'] = this._title;
    return data;
  }
}

class CatImage {
  String? _name;
  String? _path;
  CatImage({String? name, String? path}) {
    this._name = name;
    this._path = path;
  }
  String? get name => _name;
  String? get path => _path;

  factory CatImage.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? CatImage()
        : CatImage(name: json['image'], path: json['path']);
  }
}
