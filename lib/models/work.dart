import 'package:cloud_firestore/cloud_firestore.dart';

class Work {
  final String id;
  final String message;
  final double score;
  final Timestamp start_date;
  final Timestamp end_date;

  Work({this.id, this.message, this.score, this.start_date, this.end_date});

  factory Work.fromMap(Map<String, dynamic> data) {
    return Work(
      id: '',
      message: data['message'],
      score: data['score'],
      start_date: data['start_date'],
      end_date: data['end_date'],
    );
  }

  factory Work.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Work(
      id: doc.documentID,
      message: data['message'],
      score: data['score'],
      start_date: data['start_date'],
      end_date: data['end_date'],
    );
  }
}
