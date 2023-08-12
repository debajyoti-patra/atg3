import 'dart:async';

import 'package:atg_assignment3/Data/NoteData.dart';
import 'package:atg_assignment3/Data/repositories.dart';
import 'package:atg_assignment3/models/note_models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitialState()) {
    on<NoteInitialEvent>(noteInitial);
    on<NoteToDetailsNavigateEvent>(noteToDetailsNavigateEvent);
    on<NoteFromDetailsNavigateEvent>(noteFromDetailsNavigateEvent);
    on<NoteToAddNavigateEvent>(noteToAddNavigateEvent);
    on<NoteFromAddNavigateEvent>(noteFromAddNavigateEvent);
    on<NoteSaveEvent>(noteSaveEvent);
    on<NoteDeleteEvent>(noteDeleteEvent);
  }

  FutureOr<void> noteInitial(
      NoteInitialEvent event, Emitter<NoteState> emit) async {
    emit(NoteLodingState());
    NoteData.notes = await NotesRepository().getAllNotes();
    emit(NoteLodedState(notes: NoteData.notes));
  }

  FutureOr<void> noteToDetailsNavigateEvent(
      NoteToDetailsNavigateEvent event, Emitter<NoteState> emit) {
    emit(NoteToDetailsNavigateState(noteModel: event.noteModel));
  }

  FutureOr<void> noteFromDetailsNavigateEvent(
      NoteFromDetailsNavigateEvent event, Emitter<NoteState> emit) {
    emit(NoteFromDetailsNavigateState());
  }

  FutureOr<void> noteToAddNavigateEvent(
      NoteToAddNavigateEvent event, Emitter<NoteState> emit) {
    emit(
      NoteToAddNavigateState(),
    );
  }

  FutureOr<void> noteFromAddNavigateEvent(
      NoteFromAddNavigateEvent event, Emitter<NoteState> emit) {
    emit(NoteFromAddNavigateState());
  }

  FutureOr<void> noteSaveEvent(
    NoteSaveEvent event, Emitter<NoteState> emit) async {
    NoteData.notes.add(event.noteModel);
    emit(NoteFromAddNavigateState());
    NotesRepository().addANote(noteModel: event.noteModel);
  }

  FutureOr<void> noteDeleteEvent(
      NoteDeleteEvent event, Emitter<NoteState> emit) {
    NoteData.notes.remove(event.noteModel);
    NotesRepository().deleteNote(event.noteModel);
    emit(NoteLodedState(notes: NoteData.notes));
  }
}
