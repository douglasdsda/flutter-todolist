import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  DocumentReference reference;

  TodoModel({this.reference, this.title = '', this.check = false});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
        check: doc['check'], title: doc['title'], reference: doc.reference);
  }
}
