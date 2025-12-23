class SlideModel {
  int? id;
  String? url;
  String? path;

  SlideModel({
    this.id,
    this.url,
    this.path,
  });

  SlideModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'path': path,
    };
  }
}
