import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../blocs.dart';

part 'note_detail_event.dart';
part 'note_detail_state.dart';

class NoteDetailBloc extends Bloc<NoteDetailEvent, NoteDetailState> {
  final AuthBloc _authBloc;
  final NotesRepository _notesRepository;

  NoteDetailBloc({AuthBloc authBloc, NotesRepository notesRepository})
      : _authBloc = authBloc,
        _notesRepository = notesRepository,
        super(NoteDetailState.empty());

  @override
  Stream<NoteDetailState> mapEventToState(
    NoteDetailEvent event,
  ) async* {
    if (event is NoteLoaded) {
      yield* _mapNoteLoadedToState(event);
    } else if (event is NoteContentUpdated) {
      yield* _mapNoteContentUpdatedToState(event);
    } else if (event is NoteColorUpdated) {
      yield* _mapNoteColorUpdatedToState(event);
    } else if (event is NoteAdded) {
      yield* _mapNoteAddedToState();
    } else if (event is NoteSaved) {
      yield* _mapNoteSavedToState();
    } else if (event is NoteDeleted) {
      yield* _mapNoteDeletedToState();
    }
  }

  String _getCurrentUserId() {
    final authState = _authBloc.state;
    String currentUserId;
    if (authState is Anonymous) {
      currentUserId = authState.user.id;
    } else if (authState is Authenticated) {
      currentUserId = authState.user.id;
    }

    return currentUserId;
  }

  Stream<NoteDetailState> _mapNoteLoadedToState(NoteLoaded event) async* {
    yield state.copyWith(note: event.note);
  }

  Stream<NoteDetailState> _mapNoteContentUpdatedToState(
      NoteContentUpdated event) async* {
    if (state.note == null) {
      final currentUserId = _getCurrentUserId();
      // If note doesn't exist, create a new note
      final note = Note(
          userId: currentUserId,
          content: event.content,
          color: HexColor('#E74C3C'),
          timestamp: DateTime.now());
      yield state.copyWith(note: note);
    } else {
      yield state.copyWith(note: state.note.copyWith(content: event.content));
    }
  }

  Stream<NoteDetailState> _mapNoteColorUpdatedToState(
      NoteColorUpdated event) async* {
    final currentUserId = _getCurrentUserId();
    if (state == null) {
      final note = Note(
          userId: currentUserId,
          content: '',
          color: event.color,
          timestamp: DateTime.now());
      yield state.copyWith(note: note);
    } else {
      yield state.copyWith(
          note: state.note.copyWith(color: event.color, userId: currentUserId));
    }
  }

  Stream<NoteDetailState> _mapNoteAddedToState() async* {
    yield NoteDetailState.submitting(note: state.note);

    try {
      await _notesRepository.addNote(state.note);
      yield NoteDetailState.success(note: state.note);
    } on Exception catch (_) {
      yield NoteDetailState.failure(
          note: state.note, errorMessage: 'Note could not be added. Try again');
      // Reset note state
      _resetNoteState();
    }
  }

  Stream<NoteDetailState> _mapNoteSavedToState() async* {
    yield NoteDetailState.submitting(note: state.note);
    try {
      await _notesRepository.updateNote(state.note);
      yield NoteDetailState.success(note: state.note);
    } on Exception catch (_) {
      yield NoteDetailState.failure(
          note: state.note, errorMessage: 'Note could not be saved. Try again');

      _resetNoteState();
    }
  }

  Stream<NoteDetailState> _mapNoteDeletedToState() async* {
    yield NoteDetailState.submitting(note: state.note);

    try {
      await _notesRepository.deleteNote(state.note);
      yield NoteDetailState.success(note: state.note);
    } on Exception catch (_) {
      yield NoteDetailState.failure(
          note: state.note,
          errorMessage: 'Note could not be deleted. Try again');

      _resetNoteState();
    }
  }

  Stream<NoteDetailState> _resetNoteState() async* {
    yield state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        errorMessage: '');
  }
}
