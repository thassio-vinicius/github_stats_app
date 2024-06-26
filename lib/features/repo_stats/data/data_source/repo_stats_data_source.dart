import 'package:github_stats_app/core/http/apis.dart';
import 'package:github_stats_app/core/http/client.dart';
import 'package:github_stats_app/features/repo_stats/data/models/repo_files_model.dart';

abstract class RepoStatsDataSource {
  const RepoStatsDataSource();

  Future<RepoFilesModel> getRepo(
    String repoName,
    String repoOwner,
    String branch,
  );
  Future<String> getFileContent(
    String repoName,
    String repoOwner,
    String filePath,
    String branch,
  );
}

class RepoStatsDataSourceImpl extends RepoStatsDataSource {
  final HTTP _http;

  const RepoStatsDataSourceImpl(this._http);
  @override
  Future<RepoFilesModel> getRepo(
      String repoName, String repoOwner, String branch) async {
    try {
      final url =
          '${APIs.repos}/$repoOwner/$repoName/git/trees/$branch?recursive=1';
      final response = await _http.githubClient.get(url);

      if (response.statusCode != 200) {
        throw const FormatException();
      }

      return RepoFilesModel.fromJson(Map.from(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getFileContent(
    String repoName,
    String repoOwner,
    String filePath,
    String branch,
  ) async {
    try {
      final url = '$repoOwner/$repoName/$branch/$filePath';
      final response = await _http.rawGithubClient.get(url);

      return response.data.toString();
    } catch (e) {
      rethrow;
    }
  }
}
