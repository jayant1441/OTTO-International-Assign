class BookmarkModel {
  BookmarkModel({
      this.email, 
      this.imageUrl,});

  BookmarkModel.fromJson(dynamic json) {
    email = json['email'];
    imageUrl = json['imageUrl'];
  }
  String? email;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['imageUrl'] = imageUrl;
    return map;
  }

}