import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String title;
  String description;
  String? id;
  NoteModel({required this.title,  required this.description, this.id});

  toJson() {
    return {'title': title, 'description': description, 'id': id};
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      description: map['description'] as String,
      id: map['id'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'id':id
    };
  }
}
