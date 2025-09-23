import 'package:dio/dio.dart';
import 'package:hotelapp/core/databases/cache/cache_helper.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: true,printEmojis: true));

  @override
  void onError( DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d('Error type: ${err.error} \n '
        'Error message: ${err.message}'); //Debug log
    handler.next(err); //Continue with the Error
  }
@override
void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  final path = options.path;

  // ✅ تجاهل التوكن في المسارات اللي مش محتاجة توثيق
  if (!(path.contains("/api/register") || path.contains("/auth") || path.contains("/Categories"))) {
    final token = CacheHelper().getData(key: 'token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  final requestPath = '${options.baseUrl}${options.path}';
  logger.i('${options.method} request ==> $requestPath');
  logger.w('Headers: ${options.headers}');

  handler.next(options);
}


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}'); // Debug log
    handler.next(response); // continue with the Response
  }
}