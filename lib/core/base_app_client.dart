import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/injection_container.dart';
import 'package:weatherapptask/navigation_service.dart';
import 'package:weatherapptask/view_models/auth_view_model.dart';


class BaseAppClient {
  String baseAppUrl;

  BaseAppClient(this.baseAppUrl);

  Future<Dio> get _dio async {
    Dio dio = Dio(BaseOptions(
      baseUrl: baseAppUrl,
      connectTimeout: const Duration(seconds: 9000),
      receiveTimeout: const Duration(seconds: 90000),
      headers: <String, dynamic>{
        'api': '1.0.0',
        "device-type": "mobile",
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ))
      ..interceptors.add(
          LogInterceptor(request: true, requestBody: true, responseBody: true));

    return dio;
  }

  Future<Response?> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      Dio dio = await _dio;

      final params = <String, dynamic>{
        if (queryParameters != null) ...queryParameters,
        'appid': di<AuthController>().apiKey,
      };

      final response = await dio.get(
        path,
        options: options,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      print('Error in GET request: $e');
      return null;
    }
  }


}
