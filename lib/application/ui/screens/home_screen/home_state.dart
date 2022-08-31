import 'package:flutter/material.dart';

@immutable
class HomeState {
  final List<Question>? questions;
  final bool isLoading;
  final bool complete;
  final bool isFailed;

  const HomeState({
    this.questions,
    this.isLoading = false,
    this.complete = false,
    this.isFailed = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          questions == other.questions &&
          isLoading == other.isLoading &&
          complete == other.complete &&
          isFailed == other.isFailed;

  @override
  int get hashCode =>
      questions.hashCode ^
      isLoading.hashCode ^
      complete.hashCode ^
      isFailed.hashCode;

  HomeState copyWith({
    List<Question>? questions,
    bool? isLoading,
    bool? complete,
    bool? isFailed,
  }) {
    return HomeState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      complete: complete ?? this.complete,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  factory HomeState.loading() => const HomeState(
        questions: [],
        isLoading: true,
      );

  factory HomeState.data(List<Question> data) => HomeState(
        questions: data,
      );

  factory HomeState.complete() => const HomeState(
        questions: [],
        complete: true,
      );

  factory HomeState.failed() => const HomeState(
        questions: [],
        isFailed: true,
      );
}

@immutable
class Question {
  final String question;
  final bool answer;
  final String? url;
  const Question({required this.answer, required this.question, this.url});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Question &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer &&
              url == other.url;

  @override
  int get hashCode => question.hashCode ^ answer.hashCode ^ url.hashCode;

  Question copyWith({
    String? question,
    bool? answer,
    String? url,
  }) {
    return Question(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      url: url ?? this.url,
    );
  }
}