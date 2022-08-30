import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view_model.dart';
import 'package:flutter_app/core/domain/entity/database_questions.dart';
import 'package:flutter_app/core/domain/providers/questions_data_provider.dart';

class FirebaseDataService {
  final _firebaseFirestoreApi = FirebaseFirestoreApi();
  late final DocumentSnapshot<Map<String, dynamic>> _snapshot;

  Future<List<Question>> getQuestionsList() async {
    _snapshot = await _firebaseFirestoreApi.getQuestionsSnapshot();
    var jsonData = <String, dynamic>{};
    if (!_snapshot.exists || _snapshot.data() == null) {
      throw FirebaseException(
        message: '''Snapshot doesn't exist''',
        plugin: '',
        code: '',
      );
    } else {
      jsonData = _snapshot.data() as Map<String, dynamic>;
    }
    final questionList = (DatabaseQuestions.fromJson(jsonData).questions ?? [])
        .map(
          (question) => Question(
            answer: question.questionAnswer!,
            question: question.questionText!,
          ),
        )
        .toList();
    if (questionList.isEmpty) {
      throw FirebaseException(
        message: '''Snapshot doesn't exist''',
        plugin: '',
        code: '',
      );
    }
    throw FirebaseException(
      message: '''Snapshot doesn't exist''',
      plugin: '',
      code: '',
    );
    return questionList;
  }
}
