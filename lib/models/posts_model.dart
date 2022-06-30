class PostsModel {
  List<PostData> data = [];
  PostsModel.fromJson(List<dynamic> json) {
    json.forEach((element) {
      data.add(PostData.fromJson(element));
    });
  }
}

class PostData {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}
