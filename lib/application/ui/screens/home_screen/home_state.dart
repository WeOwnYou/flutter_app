import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view_model.dart';

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
