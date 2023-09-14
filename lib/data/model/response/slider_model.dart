class ImageSlider {
  ImageSlider({
    this.slider,
  });

  List<Slider>? slider;

  factory ImageSlider.fromJson(Map<String, dynamic> json) => ImageSlider(
        slider:
            List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider": List<dynamic>.from(slider!.map((x) => x.toJson())),
      };
}

class Slider {
  Slider({
    this.code,
    this.id,
    this.image,
  });

  String? code;
  int? id;
  Image? image;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        code: json["code"],
        id: json["id"],
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "image": image!.toJson(),
      };
}

class Image {
  Image({
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

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
