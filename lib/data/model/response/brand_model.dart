// class BrandModel {
//   int id;
//   String code;
//   int order;
//   BrandDescription description;

//   BrandModel({
//     this.id,
//     this.code,
//     this.order,
//     this.description,
//   });

//   BrandModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     order = json['image'];
//     description = BrandDescription.fromjson(json['description']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['code'] = this.code;
//     data['order'] = this.order;
//     data['description'] = this.description;
//     return data;
//   }
// }

// class BrandDescription {
//   int id;
//   String language;
//   String name;
//   String description;
//   String friendlyUrl;
//   String keyWords;
//   String highlights;
//   String metaDescription;
//   String title;

//   BrandDescription({
//     this.id,
//     this.language,
//     this.name,
//     this.description,
//     this.friendlyUrl,
//     this.keyWords,
//     this.highlights,
//     this.metaDescription,
//     this.title,
//   });

//   Map toJson() => {
//         'id': id,
//         'language': language,
//         'name': name,
//         'description': description,
//         'friendlyUrl': friendlyUrl,
//         'keyWords': keyWords,
//         'highlights': highlights,
//         'metaDescription': metaDescription,
//         'title': title,
//       };

//   factory BrandDescription.fromjson(Map<String, dynamic> json) {
//     return BrandDescription(
//       id: json['id'],
//       language: json['language'],
//       name: json['name'],
//       description: json['description'],
//       friendlyUrl: json['friendlyUrl'],
//       highlights: json['highlights'],
//       metaDescription: json['metaDescription'],
//       title: json['title'],
//     );
//   }
// }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class BrandModel {
  BrandModel({
    this.code,
    this.description,
    this.id,
    this.image,
    this.order,
  });

  String? code;
  Description? description;
  int? id;
  BrandImage? image;
  int? order;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        code: json["code"],
        description: Description.fromJson(json["description"]),
        id: json["id"],
        image:
            json["image"] == null ? null : BrandImage.fromJson(json["image"]),
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description!.toJson(),
        "id": id,
        "image": image!.toJson(),
        "order": order,
      };
}

class Description {
  Description({
    this.description,
    this.friendlyUrl,
    this.highlights,
    this.id,
    this.keyWords,
    this.language,
    this.metaDescription,
    this.name,
    this.title,
  });

  String? description;
  String? friendlyUrl;
  String? highlights;
  int? id;
  String? keyWords;
  String? language;
  String? metaDescription;
  String? name;
  String? title;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        description: json["description"],
        friendlyUrl: json["friendlyUrl"],
        highlights: json["highlights"],
        id: json["id"],
        keyWords: json["keyWords"],
        language: json["language"],
        metaDescription: json["metaDescription"],
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "friendlyUrl": friendlyUrl,
        "highlights": highlights,
        "id": id,
        "keyWords": keyWords,
        "language": language,
        "metaDescription": metaDescription,
        "name": name,
        "title": title,
      };
}

class BrandImage {
  BrandImage({
    this.defaultImage,
    this.externalUrl,
    this.id,
    this.imageName,
    this.imageType,
    this.imageUrl,
    this.videoUrl,
  });

  bool? defaultImage;
  String? externalUrl;
  int? id;
  String? imageName;
  int? imageType;
  String? imageUrl;
  String? videoUrl;

  factory BrandImage.fromJson(Map<String, dynamic> json) => BrandImage(
        defaultImage: json["defaultImage"],
        externalUrl: json["externalUrl"],
        id: json["id"],
        imageName: json["name"],
        imageType: json["imageType"],
        imageUrl: json["path"],
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "defaultImage": defaultImage,
        "externalUrl": externalUrl,
        "id": id,
        "imageName": imageName,
        "imageType": imageType,
        "imageUrl": imageUrl,
        "videoUrl": videoUrl,
      };
}
