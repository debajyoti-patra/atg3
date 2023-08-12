part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class NoteInitialEvent extends NoteEvent{}


class NoteToDetailsNavigateEvent extends NoteEvent{
  NoteModel noteModel;
  NoteToDetailsNavigateEvent({required this.noteModel});
}

class NoteFromDetailsNavigateEvent extends NoteEvent{
}

class NoteToAddNavigateEvent extends NoteEvent{
}

class NoteFromAddNavigateEvent extends NoteEvent{
}

class NoteSaveEvent extends NoteEvent{
  NoteModel noteModel;
  NoteSaveEvent({required this.noteModel});
}

class NoteDeleteEvent extends NoteEvent{
  NoteModel noteModel;
  NoteDeleteEvent({required this.noteModel});
}