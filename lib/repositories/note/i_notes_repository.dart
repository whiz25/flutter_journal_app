import '../../models/note/note_model.dart';

abstract class INotesRepository {
  Future<Note> addNote(Note note);
  Future<Note> updateNote(Note note);
  Future<Note> deleteNote(Note note);
  Stream<List<Note>> allNotes({String userId});
}
