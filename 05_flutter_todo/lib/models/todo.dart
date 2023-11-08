import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late int? id;
  late String title;
  late String description;
  late DocumentReference? reference;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.reference,
  });

  //dynamic : 타입 체크를 하지 않고 런타임에 객체의 타입을 결정
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  //클래스명.생성자명() : 이름이 있는 생성자
  //sqlite로 읽은 데이터는 dynamic 타입으로 받자
  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    description = map?['description'];
  }

  //클래스명.생성자명() : 이름이 있는 생성자
  Todo.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    id = map['id'];
    title = map['title'];
    description = map['description'];
    reference = document.reference;
  }
}
