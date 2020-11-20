import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/paths.dart';
import '../../entities/entities.dart';
import '../../models/note/note_model.dart';
import 'i_notes_repository.dart';

class NotesRepository extends INotesRepository {
  final FirebaseFirestore _firebaseFirestore;

  NotesRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Note> addNote(Note note) async {
    await _firebaseFirestore
        .collection(Paths.notes)
        .doc(note.id)
        .set(note.toEntity().toDocument());
    return note;
  }

  @override
  Future<Note> deleteNote(Note note) async {
    await _firebaseFirestore.collection(Paths.notes).doc(note.id).delete();
    return note;
  }

  @override
  Future<Note> updateNote(Note note) async {
    await _firebaseFirestore
        .collection(Paths.notes)
        .doc(note.id)
        .update(note.toEntity().toDocument());
    return note;
  }

  @override
  Stream<List<Note>> allNotes({@required String userId}) => _firebaseFirestore
      .collection(Paths.notes)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Note.fromEntity(NoteEntity.fromDocument(doc: doc)))
          .toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
}
