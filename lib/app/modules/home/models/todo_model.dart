import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  final DocumentReference reference;

  TodoModel({this.reference, this.title, this.check});

  factory TodoModel.fromDocument(DocumentSnapshot doc){
      return TodoModel(check: doc['check'], title: doc['title'], reference: doc.reference);
  }

  save(){
    if(reference == null) {
        // adicionar um novo item
    } else {
      reference.updateData({
        'title': title,
        'check': check
      });
    }
  }

}