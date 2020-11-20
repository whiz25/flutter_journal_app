import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

part 'note_detail_event.dart';
part 'note_detail_state.dart';

class NoteDetailBloc extends Bloc<NoteDetailEvent, NoteDetailState> {
  NoteDetailBloc() : super(NoteDetailState.empty());

  @override
  Stream<NoteDetailState> mapEventToState(
    NoteDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
