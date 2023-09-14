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
  List<Children>? _children;
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
      List<Children>? children,
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
  List<Children>? get children => _children;
  Description? get description => _description;

  factory Category.fromJson(Map<String, dynamic> json) {
    return json == null
        ? Category()
        : Category(
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
            children: json['children'] == null
                ? null
                : (json['children'] as List<dynamic>)
                    .map((child) => Children.fromJson(child))
                    .toList(),
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
  Children? _children;
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
    this._children = children;
  }
  int? get id => _id;
  String? get code => _code;
  int? get sortOrder => _sortOrder;
  bool? get visible => _visible;
  bool? get featured => _featured;
  String? get lineage => _lineage;
  int? get depth => _depth;
  CatParent? get catParent => _parent;
  Description? get description => _description;
  int? get productCount => _productCount;
  String? get store => _store;
  CatImage? get image => _image;
  Children? get children => _children;

  factory Children.fromJson(Map<String, dynamic> json) {
    return json == null
        ? Children()
        : Children(
            id: json['id'],
            sortOrder: json['sortOrder'],
            visible: json['visible'],
            featured: json['featured'],
            lineage: json['lineage'],
            depth: json['depth'],
            parent: CatParent.fromJson(json['parent']),
            description: Description.fromJson(json['description']),
            productCount: json['productCount'],
            store: json['store'],
            image: CatImage.fromJson(json['image']),
            children: null);
  }
}

class CatParent {
  int? _id;
  String? _code;
  CatParent({int? id, String? code}) {
    this._id = id;
    this._code = code;
  }
  int? get id => _id;
  String? get code => _code;
  factory CatParent.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? CatParent()
        : CatParent(id: json['id'], code: json['code']);
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

  factory Description.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? Description()
        : Description(
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

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
class CategoryDefinition {
  CategoryDefinition({
    this.id,
    this.code,
    this.name,
    this.lineage,
    this.depth,
    this.parent,
    this.imageUrl,
  });

  int? id;
  String? code;
  String? name;
  String? lineage;
  int? depth;
  dynamic parent;
  dynamic imageUrl;

  factory CategoryDefinition.fromJson(Map<String, dynamic> json) =>
      CategoryDefinition(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        lineage: json["lineage"],
        depth: json["depth"],
        parent: json["parent"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "lineage": lineage,
        "depth": depth,
        "parent": parent,
        "imageUrl": imageUrl,
      };
}

// class Category {
//   int _id;
//   String _name;
//   String _slug;
//   String _icon;
//   String _parentId;
//   String _position;
//   String _createdAt;
//   String _updatedAt;
//   List<SubCategory> _subCategories;

//   Category(
//       {int id,
//         String name,
//         String slug,
//         String icon,
//         String parentId,
//         String position,
//         String createdAt,
//         String updatedAt,
//         List<SubCategory> subCategories}) {
//     this._id = id;
//     this._name = name;
//     this._slug = slug;
//     this._icon = icon;
//     this._parentId = parentId;
//     this._position = position;
//     this._createdAt = createdAt;
//     this._updatedAt = updatedAt;
//     this._subCategories = subCategories;
//   }

//   int get id => _id;
//   String get name => _name;
//   String get slug => _slug;
//   String get icon => _icon;
//   String get parentId => _parentId;
//   String get position => _position;
//   String get createdAt => _createdAt;
//   String get updatedAt => _updatedAt;
//   List<SubCategory> get subCategories => _subCategories;

//   Category.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _name = json['name'];
//     _slug = json['slug'];
//     _icon = json['icon'];
//     _parentId = json['parent_id'];
//     _position = json['position'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     if (json['childes'] != null) {
//       _subCategories =  [];
//       json['childes'].forEach((v) {
//         _subCategories.add(new SubCategory.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['name'] = this._name;
//     data['slug'] = this._slug;
//     data['icon'] = this._icon;
//     data['parent_id'] = this._parentId;
//     data['position'] = this._position;
//     data['created_at'] = this._createdAt;
//     data['updated_at'] = this._updatedAt;
//     if (this._subCategories != null) {
//       data['childes'] = this._subCategories.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SubCategory {
//   int _id;
//   String _name;
//   String _slug;
//   Null _icon;
//   String _parentId;
//   String _position;
//   String _createdAt;
//   String _updatedAt;
//   List<SubSubCategory> _subSubCategories;

//   SubCategory(
//       {int id,
//         String name,
//         String slug,
//         Null icon,
//         String parentId,
//         String position,
//         String createdAt,
//         String updatedAt,
//         List<SubSubCategory> subSubCategories}) {
//     this._id = id;
//     this._name = name;
//     this._slug = slug;
//     this._icon = icon;
//     this._parentId = parentId;
//     this._position = position;
//     this._createdAt = createdAt;
//     this._updatedAt = updatedAt;
//     this._subSubCategories = subSubCategories;
//   }

//   int get id => _id;
//   String get name => _name;
//   String get slug => _slug;
//   Null get icon => _icon;
//   String get parentId => _parentId;
//   String get position => _position;
//   String get createdAt => _createdAt;
//   String get updatedAt => _updatedAt;
//   List<SubSubCategory> get subSubCategories => _subSubCategories;

//   SubCategory.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _name = json['name'];
//     _slug = json['slug'];
//     _icon = json['icon'];
//     _parentId = json['parent_id'];
//     _position = json['position'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     if (json['childes'] != null) {
//       _subSubCategories =  [];
//       json['childes'].forEach((v) {
//         _subSubCategories.add(new SubSubCategory.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['name'] = this._name;
//     data['slug'] = this._slug;
//     data['icon'] = this._icon;
//     data['parent_id'] = this._parentId;
//     data['position'] = this._position;
//     data['created_at'] = this._createdAt;
//     data['updated_at'] = this._updatedAt;
//     if (this._subSubCategories != null) {
//       data['childes'] = this._subSubCategories.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SubSubCategory {
//   int _id;
//   String _name;
//   String _slug;
//   Null _icon;
//   String _parentId;
//   String _position;
//   String _createdAt;
//   String _updatedAt;

//   SubSubCategory(
//       {int id,
//         String name,
//         String slug,
//         Null icon,
//         String parentId,
//         String position,
//         String createdAt,
//         String updatedAt}) {
//     this._id = id;
//     this._name = name;
//     this._slug = slug;
//     this._icon = icon;
//     this._parentId = parentId;
//     this._position = position;
//     this._createdAt = createdAt;
//     this._updatedAt = updatedAt;
//   }

//   int get id => _id;
//   String get name => _name;
//   String get slug => _slug;
//   Null get icon => _icon;
//   String get parentId => _parentId;
//   String get position => _position;
//   String get createdAt => _createdAt;
//   String get updatedAt => _updatedAt;

//   SubSubCategory.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _name = json['name'];
//     _slug = json['slug'];
//     _icon = json['icon'];
//     _parentId = json['parent_id'];
//     _position = json['position'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['name'] = this._name;
//     data['slug'] = this._slug;
//     data['icon'] = this._icon;
//     data['parent_id'] = this._parentId;
//     data['position'] = this._position;
//     data['created_at'] = this._createdAt;
//     data['updated_at'] = this._updatedAt;
//     return data;
//   }
// }




