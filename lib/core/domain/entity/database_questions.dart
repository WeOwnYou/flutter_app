class DatabaseQuestions {
  List<DatabaseQuestion>? questions;

  DatabaseQuestions({this.questions});

  DatabaseQuestions.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <DatabaseQuestion>[];
      for (final v in json['questions'] as List<dynamic>) {
        questions!.add(DatabaseQuestion.fromJson(v as Map<String, dynamic>));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DatabaseQuestion {
  String? questionText;
  String? fullAnswer;
  bool? questionAnswer;

  DatabaseQuestion({this.questionText, this.fullAnswer, this.questionAnswer});

  DatabaseQuestion.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'] as String;
    fullAnswer = json['full_answer'] as String;
    questionAnswer = json['question_answer'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['question_text'] = questionText;
    data['full_answer'] = fullAnswer;
    data['question_answer'] = questionAnswer;
    return data;
  }
}
