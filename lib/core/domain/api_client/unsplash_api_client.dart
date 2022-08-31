import 'package:dio/dio.dart';
import 'package:flutter_app/core/domain/api_client/api_client_config.dart';
import 'package:flutter_app/core/domain/entity/unsplash_photo.dart';

class UnsplashApiClient {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.unsplash.com',
    ),
  );
  Future<List<UnsplashPhoto>> getPhotos(int count) async {
    final response = _dio.get<List<dynamic>>(
      '/photos/random',
      queryParameters: <String, String>{
        'client_id': ApiClientConfig.clientId,
        'count': '$count',
      },);
    final photosList = (await response).data!.cast<Map<String, dynamic>>();
    final result = photosList.map(UnsplashPhoto.fromJson).toList();
    return result;
  }
}
