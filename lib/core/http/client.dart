import 'package:dio/dio.dart';
import 'package:github_stats_app/core/http/app_interceptor.dart';

class HTTP {
  final Dio client = createClient();

  static Dio createClient() {
    const baseUrl = 'https://api.github.com/';
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => true,
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.add(AppInterceptors(dio));

    return dio;
  }
}
