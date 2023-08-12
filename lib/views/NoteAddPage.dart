import 'package:atg_assignment3/models/note_models.dart';
import 'package:atg_assignment3/views/NotesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../controllers/bloc/note_bloc.dart';
import '../widgets/custom_appbar.dart';

class NoteAddPage extends StatelessWidget {
  NoteAddPage({super.key});
  FocusNode focusNode = FocusNode();
  NoteBloc noteBloc = NoteBloc();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      bloc: noteBloc,
      listenWhen: (previous, current) => current is NoteActionState,
      buildWhen: (previous, current) => current is! NoteActionState,
      listener: (context, state) {
        if (state is NoteFromAddNavigateState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NotesPage(),
              ));
        
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: 'AddNote',
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: InkWell(
                    onTap: () {
                      String id = Uuid().v1();
                      noteBloc.add(
                        NoteSaveEvent(
                          noteModel: NoteModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              id: id),
                        ),
                      );
                    },
                    child: const Icon(Icons.save),
                  ),
                )
              ],
              child: InkWell(
                onTap: () {
                  noteBloc.add(NoteFromAddNavigateEvent());
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  onSubmitted: (value) {
                    focusNode.requestFocus();
                  },
                  style: const TextStyle(fontSize: 30),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Title'),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: descriptionController,
                  focusNode: focusNode,
                  maxLines: null,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Description'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
