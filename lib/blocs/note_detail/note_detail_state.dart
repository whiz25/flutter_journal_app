part of 'note_detail_bloc.dart';

@immutable
class NoteDetailState extends Equatable {
  final Note note;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  const NoteDetailState(
      {@required this.note,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.errorMessage});

  @override
  List<Object> get props =>
      [note, isSubmitting, isSuccess, isFailure, errorMessage];

  @override
  String toString() =>
      'NoteDetailState {note: $note, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, errorMessage: $errorMessage}';

  factory NoteDetailState.empty() => const NoteDetailState(
      note: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '');

  factory NoteDetailState.submitting({@required Note note}) => NoteDetailState(
      note: note,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: '');

  factory NoteDetailState.success({@required Note note}) => NoteDetailState(
      note: note,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: '');

  factory NoteDetailState.failure(
          {@required Note note, @required String errorMessage}) =>
      NoteDetailState(
          note: note,
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
          errorMessage: errorMessage);

  NoteDetailState copyWith(
          {Note note,
          bool isSubmitting,
          bool isSuccess,
          bool isFailure,
          String errorMessage}) =>
      NoteDetailState(
          note: note ?? this.note,
          isSubmitting: isSubmitting ?? this.isSubmitting,
          isSuccess: isSuccess ?? this.isSuccess,
          isFailure: isFailure ?? this.isFailure,
          errorMessage: errorMessage ?? this.errorMessage);
}
