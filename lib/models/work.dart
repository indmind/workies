import 'package:cloud_firestore/cloud_firestore.dart';

class Work {
  final String message;
  final double score;
  final Timestamp start_date;
  final Timestamp end_date;

  Work({this.message, this.score, this.start_date, this.end_date});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      message: json['message'],
      score: json['score'],
      start_date: json['start_date'],
      end_date: json['end_date'],
    );
  }
}
