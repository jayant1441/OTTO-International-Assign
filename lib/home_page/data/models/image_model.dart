class ImageModel {
  ImageModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.altDescription, 
      this.likes, 
      this.urlOfImages,});

  ImageModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    altDescription = json['alt_description'];
    likes = json['likes'];
    urlOfImages = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  String? altDescription;
  int? likes;
  Urls? urlOfImages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['alt_description'] = altDescription;
    map['likes'] = likes;
    if (urlOfImages != null) {
      map['urls'] = urlOfImages!.toJson();
    }
    return map;
  }

}

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,});

  Urls.fromJson(dynamic json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = raw;
    map['full'] = full;
    map['regular'] = regular;
    map['small'] = small;
    map['thumb'] = thumb;
    map['small_s3'] = smallS3;
    return map;
  }

}