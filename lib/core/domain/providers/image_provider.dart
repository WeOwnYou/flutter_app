import 'package:dio/dio.dart';
import 'package:flutter_app/configuration/api_config.dart';
import 'package:flutter_app/core/domain/entity/unsplash_photo.dart';

class UnsplashImageProvider {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.unsplash.com',
    ),
  );
  Future<List<UnsplashPhoto>> getPhoto(int count) async {
    final response = dio.get<List<dynamic>>(
      '/photos/random',
      queryParameters: <String, String>{
        'client_id': ApiConfig.clientId,
        'count': '$count',
      },);
    final photosList = (await response).data!.cast<Map<String, dynamic>>();
    final result = photosList.map(UnsplashPhoto.fromJson).toList();
    return result;
  }
}
