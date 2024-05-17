import 'dart:async';

import 'package:dio/dio.dart';
import 'package:github_stats_app/core/utils/print.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Print.magenta("URL >> ${options.uri}");
    Print.magenta("Data >> ${options.data}");

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Print.red(
      "Response err >> ${err.message}, Endpoint = ${err.requestOptions.path}",
    );

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Print.green("Response data >> ${response.data}");
    super.onResponse(response, handler);
  }
}
