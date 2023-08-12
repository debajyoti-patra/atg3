import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/note_models.dart';

class NotesRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addANote({required NoteModel noteModel}) async {
    try {
      await _firebaseFirestore
          .collection("notes")
          .doc(noteModel.id)
          .set(noteModel.toMap());
    } on FirebaseException {
      if (kDebugMode) {
        print('exception');
      }
    }
  }

  Future<List<NoteModel>> getAllNotes() async {
    final List<NoteModel> notesList = [];
    try {
      final allNotes = await _firebaseFirestore.collection("notes").get();
      for (var element in allNotes.docs) {
        notesList.add(
          NoteModel.fromMap(element.data()),
        );
      }
      return notesList;
    } on FirebaseException {
      return notesList;
    }
  }

  Future<void> deleteNote(NoteModel noteModel) async {
    try {
      print(noteModel.id);
      await _firebaseFirestore.collection("notes").doc(noteModel.id).delete();
    } on FirebaseException {
      print('exception');
    }
  }
}
