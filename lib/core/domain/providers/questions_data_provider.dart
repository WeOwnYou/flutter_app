import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionDataProvider {
  Future<List<Map<String, dynamic>>> getJsonData() async {
    var jsonData = <Map<String, dynamic>>[];
    final snapshot = await FirebaseFirestore.instance
        .collection('/quiz_questions')
        .doc('HnPA3a7NcN2ymCvWCOzW')
        .get();
    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception('''Snapshot doesn't exist''');
    } else {
      jsonData = ((snapshot.data() as Map<String, dynamic>)['questions']
              as List<dynamic>)
          .cast<Map<String, dynamic>>();
    }
    return jsonData;
  }
}
