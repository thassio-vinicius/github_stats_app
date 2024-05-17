import 'package:dartz/dartz.dart';
import 'package:github_stats_app/core/http/client.dart';

abstract class RepoStatsDataSource {
  const RepoStatsDataSource();

  Future<Either<Exception, String>> getRepo(String repoName);
}

class RepoStatsDataSourceImpl extends RepoStatsDataSource {
  final HTTP client;

  const RepoStatsDataSourceImpl(this.client);
  @override
  Future<Either<Exception, String>> getRepo(String repoName) {
    // TODO: implement getRepo
    throw UnimplementedError();
  }
}
