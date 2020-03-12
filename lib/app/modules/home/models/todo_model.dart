import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  DocumentReference reference;
  int id;

  TodoModel({this.reference, this.title = '', this.check = false, this.id});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
        check: doc['check'], title: doc['title'], reference: doc.reference);
  }

   factory TodoModel.fromJson(Map doc) {
    return TodoModel(
        check: doc['check'], title: doc['title'], id: doc['id']);
  }
}
