import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/domain/entity/database_questions.dart';

class FirebaseFirestoreApiClient {
  Future<DatabaseQuestions> getQuestionsSnapshot(String collectionName, String documentName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('/$collectionName')
        .doc(documentName)
        .get();
    _validateResponse(snapshot);
    return DatabaseQuestions.fromJson(snapshot.data()!);
  }

  void _validateResponse(DocumentSnapshot snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      throw FirebaseException(
        message: "Snapshot doesn't exist",
        plugin: '',
      );
    }
  }
}
