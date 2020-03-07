import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workies/models/work.dart';

class DatabaseService {
  final CollectionReference _worksRef = Firestore.instance.collection('works');

  Future<Work> getWork(String id) async {
    DocumentSnapshot workSnapshot = await _worksRef.document(id).get();

    return Work.fromFirestore(workSnapshot);
  }

  Stream<Work> streamWork(String id) {
    return _worksRef
        .document(id)
        .snapshots()
        .map((snapshot) => Work.fromFirestore(snapshot));
  }

  Stream<List<Work>> streamAllWorks() {
    return _worksRef.snapshots().map((list) =>
        list.documents.map((doc) => Work.fromFirestore(doc)).toList());
  }
}
