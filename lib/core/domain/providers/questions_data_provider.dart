import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreApi {
  final collectionName = 'quiz_questions';
  final documentName = 'HnPA3a7NcN2ymCvWCOzW';
  Future<DocumentSnapshot<Map<String, dynamic>>> getQuestionsSnapshot() async {
    final snapshot = FirebaseFirestore.instance
        .collection('/$collectionName')
        .doc(documentName)
        .get();
    return snapshot;
  }
}
