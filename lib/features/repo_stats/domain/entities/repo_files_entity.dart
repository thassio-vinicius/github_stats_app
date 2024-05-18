import 'package:equatable/equatable.dart';
import 'package:github_stats_app/core/utils/programming_language_helper.dart';
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

  List<RepoTreeEntity> languageFiles(List<ProgrammingLanguage> languages) {
    final firstLanguageExtension =
        ProgrammingLanguageHelper.getExtension(languages.first);
    final lastLanguageExtension = languages.length == 1
        ? null
        : ProgrammingLanguageHelper.getExtension(languages.last);

    final items = <RepoTreeEntity>[];
    for (var item in (tree ?? [])) {
      if ((item.path?.endsWith(firstLanguageExtension) ?? false) ||
          (item.path?.endsWith(lastLanguageExtension) ?? false)) {
        items.add(item);
      }
    }
    return items;
  }

  @override
  List<Object?> get props => [sha, url, tree, truncated];
}
