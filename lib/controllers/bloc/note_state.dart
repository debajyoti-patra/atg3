part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteActionState extends NoteState {}

class NoteInitialState extends NoteState {}

class NoteLodingState extends NoteState {}

class NoteLodedState extends NoteState {
  List<NoteModel> notes;
  NoteLodedState({required this.notes});
}

class NoteToAddNavigateState extends NoteActionState {}

class NoteFromAddNavigateState extends NoteActionState {}

class NoteToDetailsNavigateState extends NoteActionState {
  NoteModel noteModel;
  NoteToDetailsNavigateState({required this.noteModel});
}

class NoteFromDetailsNavigateState extends NoteActionState {}
