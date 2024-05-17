import 'package:equatable/equatable.dart';
import 'package:github_stats_app/features/repo_stats/data/models/repo_tree_model.dart';

class RepoTreeEntity extends Equatable {
  final String? path;
  final String? mode;
  final String? type;
  final String? sha;
  final int? size;
  final String? url;

  const RepoTreeEntity({
    this.path,
    this.mode,
    this.type,
    this.sha,
    this.size,
    this.url,
  });

  factory RepoTreeEntity.fromModel(RepoTreeModel model) {
    return RepoTreeEntity(
      path: model.path,
      mode: model.mode,
      type: model.type,
      sha: model.sha,
      size: model.size,
      url: model.url,
    );
  }

  @override
  List<Object?> get props => [path, mode, type, sha, size, url];
}
