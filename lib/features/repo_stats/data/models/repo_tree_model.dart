class RepoTreeModel {
  String? path;
  String? mode;
  String? type;
  String? sha;
  int? size;
  String? url;

  RepoTreeModel({
    this.path,
    this.mode,
    this.type,
    this.sha,
    this.size,
    this.url,
  });

  RepoTreeModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    mode = json['mode'];
    type = json['type'];
    sha = json['sha'];
    size = json['size'];
    url = json['url'];
  }
}
