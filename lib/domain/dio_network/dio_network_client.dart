import 'package:dio/dio.dart';

abstract class ApiConfig {
  static const clientId = 'c1oJzOrdHEl9fu9IKiO4Ocv_Gihk8Cl3mvgFoJpuXCg';
}

class DioNetwork {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.unsplash.com',
    ),
  );
  Future<Response<dynamic>> getPhoto(int count) async {
    // TODO(type): may be not dynamic???
    final result = dio.get<dynamic>(
      '/photos/random',
      queryParameters: <String, String>{
        'client_id': ApiConfig.clientId,
        'count': '$count',
      },);
    return result;
  }
}
