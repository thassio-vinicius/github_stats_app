import 'package:dio/dio.dart';

class HTTP {
  final Dio githubClient = createGithubClient();
  final Dio rawGithubClient = createRawGithubClient();

  static Dio createGithubClient() {
    const baseUrl = 'https://api.github.com/';
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => true,
        contentType: Headers.jsonContentType,
      ),
    );

    // dio.interceptors.add(AppInterceptors(dio));

    return dio;
  }

  static Dio createRawGithubClient() {
    const baseUrl = 'https://raw.githubusercontent.com/';
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => true,
        contentType: Headers.jsonContentType,
      ),
    );

    //dio.interceptors.add(AppInterceptors(dio));

    return dio;
  }
}
