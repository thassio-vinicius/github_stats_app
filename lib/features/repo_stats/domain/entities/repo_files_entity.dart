import 'package:equatable/equatable.dart';
import 'package:github_stats_app/features/repo_stats/data/models/repo_files_model.dart';

import 'repo_tree_entity.dart';

class RepoFilesEntity extends Equatable {
  final String? sha;
  final String? url;
  final List<RepoTreeEntity>? tree;
  final bool? truncated;

  const RepoFilesEntity({
    this.sha,
    this.url,
    this.tree,
    this.truncated,
  });

  factory RepoFilesEntity.fromModel(RepoFilesModel model) {
    return RepoFilesEntity(
      sha: model.sha,
      url: model.url,
      tree: model.tree
          ?.map((treeModel) => RepoTreeEntity.fromModel(treeModel))
          .toList(),
      truncated: model.truncated,
    );
  }

  List<RepoTreeEntity> jsTsFiles() {
    final items = <RepoTreeEntity>[];
    for (var item in (tree ?? [])) {
      if ((item.path?.endsWith('.js') ?? false) ||
          (item.path?.endsWith('.ts') ?? false)) {
        items.add(item);
      }
    }
    return items;
  }

  @override
  List<Object?> get props => [sha, url, tree, truncated];
}
