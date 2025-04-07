import 'package:demo_project/common/api_service.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';

class UserApi {
  final ApiService _apiService = ApiService();

  // 用户相关
  Future<ApiResponse> login(String username, String password) async {
    return await _apiService.post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> updateUserInfo(
    Map<String, dynamic> data,
  ) async {
    return await _apiService.put<Map<String, dynamic>>(
      '/user/info',
      data: data,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getUserInfo() async {
    return await _apiService.get<Map<String, dynamic>>('/user/info');
  }

  // 文章相关
  Future<ApiResponse> getArticles({int page = 1, int pageSize = 10}) async {
    return await _apiService.get(
      '/articles',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
  }

  Future<ApiResponse> createArticle(Map<String, dynamic> articleData) async {
    return await _apiService.post('/articles', data: articleData);
  }

  Future<ApiResponse> updateArticle(
    String articleId,
    Map<String, dynamic> articleData,
  ) async {
    return await _apiService.put('/articles/$articleId', data: articleData);
  }

  Future<ApiResponse> deleteArticle(String articleId) async {
    return await _apiService.delete('/articles/$articleId');
  }

  Future<Uint8List> fetchImageData(String url) async {
    try {
      final response = await _apiService.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.code == 200) {
        return response.data;
      }
      throw Exception('Failed to fetch image data');
    } on DioException catch (e) {
      throw Exception('Failed to fetch image data: ${e.message}');
    }
  }
}
