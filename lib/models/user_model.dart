class UserModel {
  List<UserData> data = [];
  UserModel.fromJson(List<dynamic> json) {
    json.forEach((element) {
      data.add(UserData.fromJson(element));
    });
  }
}

class UserData {
  int? albumId;
  int? userId;
  String? name;
  String? url;
  String? thumbnailUrl;
  UserData.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    userId = json['userId'];
    name = json['name'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
