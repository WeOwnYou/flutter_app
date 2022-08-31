class DatabaseQuestions {
  List<DatabaseQuestion>? questions;

  DatabaseQuestions({this.questions});

  factory DatabaseQuestions.fromJson(Map<String, dynamic> json) =>
      DatabaseQuestions(
        questions: (json['questions'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map<DatabaseQuestion>(DatabaseQuestion.fromJson)
            .toList(),
      );

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

  factory DatabaseQuestion.fromJson(Map<String, dynamic> json) =>
      DatabaseQuestion(
        questionText: json['question_text'] as String,
        fullAnswer: json['full_answer'] as String,
        questionAnswer: json['question_answer'] as bool,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['question_text'] = questionText;
    data['full_answer'] = fullAnswer;
    data['question_answer'] = questionAnswer;
    return data;
  }
}
