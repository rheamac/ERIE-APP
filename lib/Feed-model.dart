import 'dart:core';

class ResponseModel {
  String id;
  String name;
  String start_time;
  String end_time;
  String created_at;
  String updated_at;
  bool is_active;
  List<QuestionModel> questions;
}

class FeedbackModel {
  String name;
  List<QuestionModel> questions;
}

class QuestionModel {
  String id;
  String title;
  String description;
  String feedback_id;
  String answer_a_id;
  String answer_b_id;
  String created_at;
  String updated_at;
  List<AnswerA> answer_a;
  List<AnswerA> answer_b;
}

class AnswerA {
  String id;
  String emotion;
  String emoji;
  String text;
  String created_at;
  String updated_at;
}
