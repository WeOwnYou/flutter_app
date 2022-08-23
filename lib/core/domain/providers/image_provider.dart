import 'package:dio/dio.dart';
import 'package:flutter_app/configuration/api_config.dart';

class UnsplashImageProvider {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.unsplash.com',
    ),
  );
  Future<List<Map<String, dynamic>>?> getPhoto(int count) async {
    final response = dio.get<List<dynamic>>(
      '/photos/random',
      queryParameters: <String, String>{
        'client_id': ApiConfig.clientId,
        'count': '$count',
      },);
    final result = (await response).data!.cast<Map<String, dynamic>>();
    return result;
  }
}
