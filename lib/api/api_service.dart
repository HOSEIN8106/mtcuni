import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/resource/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService {
  late Dio _dio;
  String? _token;

  Future<ApiService> init() async {
    _loadToken();
    return this;
  }

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoint.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_token == null) {
            await _loadToken();
          }
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }

          print('--> ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('<-- ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );

    _loadToken(); // برای اینکه سریع‌تر لود بشه
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(Constant.accessToken);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.accessToken, token);
    _token = token;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constant.accessToken);
    _token = null;
  }

  // متدهای درخواست
  Future<Response?> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      return response;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<Response?> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<Response?> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<Response?> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  void handleError(dynamic error) {
    if (error is DioException) {
      print("Dio error: ${error.response?.data}");
    } else {
      print("Unknown error: $error");
    }
  }
}
