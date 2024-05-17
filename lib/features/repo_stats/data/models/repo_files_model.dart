import 'package:github_stats_app/features/repo_stats/data/models/repo_tree_model.dart';

class RepoFilesModel {
  String? sha;
  String? url;
  List<RepoTreeModel>? tree;
  bool? truncated;

  RepoFilesModel({this.sha, this.url, this.tree, this.truncated});

  factory RepoFilesModel.fromJson(Map<String, dynamic> json) {
    return RepoFilesModel(
      sha: json['sha'],
      url: json['url'],
      truncated: json['truncated'],
      tree: List.from(json['tree'] ?? [])
          .map((e) => RepoTreeModel.fromJson(Map.from(e)))
          .toList(),
    );
  }
}
