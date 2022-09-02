import 'package:flutter_app/application/ui/screens/home_screen/home_state.dart';
import 'package:flutter_app/core/domain/api_client/api_client_config.dart';
import 'package:flutter_app/core/domain/api_client/firestore_api_client.dart';
import 'package:flutter_app/core/domain/api_client/unsplash_api_client.dart';

class QuestionsService {
  final _firebaseFirestoreApi = FirebaseFirestoreApiClient();
  final _imageApiClient = UnsplashApiClient();

  Future<List<Question>> getQuestionsList() async {
    final questions = await _firebaseFirestoreApi.getQuestionsSnapshot(
      ApiClientConfig.collectionName,
      ApiClientConfig.documentName,
    );
    if (questions.questions?.length == null || questions.questions!.isEmpty) {
      return [];
    }
    final photoList =
        await _imageApiClient.getPhotos(questions.questions!.length);
    final questionsList = List<Question>.from(
      questions.questions!.map<Question>(
        (e) => Question(
            answer: e.questionAnswer!,
            question: e.questionText!,
            url: photoList.isNotEmpty ? photoList.removeLast().urls?.small : null,),
      ),
    )..shuffle();
    return questionsList;
  }
}
