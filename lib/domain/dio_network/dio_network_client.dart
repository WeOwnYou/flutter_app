import 'package:dio/dio.dart';

class DioNetwork {
  Future<Response<dynamic>> getPhoto(int count) async {
    const clientId = 'c1oJzOrdHEl9fu9IKiO4Ocv_Gihk8Cl3mvgFoJpuXCg';

    final result = Dio().get<dynamic>(
      'https://111api.unsplash.com/photos/random',
      queryParameters: <String, String>{
        'client_id': clientId,
        'count': '$count',
      },);
    return result;
  }
}
