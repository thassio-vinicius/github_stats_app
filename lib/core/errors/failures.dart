import 'package:github_stats_app/core/errors/failure.dart';

class GenericFailure extends Failure {
  const GenericFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String? message])
      : super(message ?? "No internet connection");
}

class NoRepositoriesFailure extends Failure {
  const NoRepositoriesFailure([String? message])
      : super(message ?? "No repositories found");
}

class NoResultsForLanguageFailure extends Failure {
  const NoResultsForLanguageFailure([String? message])
      : super(message ?? "No Results for this language");
}
