import 'package:flutter/widgets.dart';

enum QuizCategory { synonym, antonym }

class Question {
  final String question;
  final String o1, o2, o3, o4;
  final String correctAnswer;
  final int difficulty;
  final QuizCategory quizCategory;

  Question(
      {@required this.question,
      @required this.o1,
      @required this.o2,
      @required this.o3,
      @required this.o4,
      @required this.correctAnswer,
      @required this.difficulty,
      @required this.quizCategory});

  factory Question.fromMap(Map data) {
    QuizCategory category = quizCategoryFromString(data['quizCategory']);
    return Question(
        question: data['question'],
        o1: data['o1'],
        o2: data['o2'],
        o3: data['o3'],
        o4: data['o4'],
        correctAnswer: data['correct_answer'],
        difficulty: data['difficulty'],
        quizCategory: category);
  }

  static QuizCategory quizCategoryFromString(String category) {
    switch (category) {
      case 'QuizCategory.synonym':
        return QuizCategory.synonym;

      default:
        return null;
    }
  }
}
