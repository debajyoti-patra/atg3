import 'package:atg_assignment3/constants/app_constants.dart';
import 'package:atg_assignment3/controllers/bloc/note_bloc.dart';
import 'package:atg_assignment3/models/note_models.dart';
import 'package:atg_assignment3/views/NoteAddPage.dart';
import 'package:atg_assignment3/views/NotesDetailsPage.dart';
import 'package:atg_assignment3/widgets/app_style.dart';
import 'package:atg_assignment3/widgets/custom_appbar.dart';
import 'package:atg_assignment3/widgets/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  NoteBloc noteBloc = NoteBloc();
  @override
  void initState() {
    noteBloc.add(NoteInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
        bloc: noteBloc,
        listenWhen: (previous, current) => current is NoteActionState,
        buildWhen: (previous, current) => current is! NoteActionState,
        listener: (context, state) => {
              if (state is NoteToAddNavigateState)
                {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => NoteAddPage(),
                    ),
                  )
                }
              else if (state is NoteToDetailsNavigateState)
                {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          NotesDetailsPage(noteModel: state.noteModel),
                    ),
                  ),
                }
            },
        builder: (context, state) {
          if (state is NoteLodedState) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: kDarkPurple,
                onPressed: () {
                  noteBloc.add(NoteToAddNavigateEvent());
                },
                child: const Icon(Icons.add),
              ),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: CustomAppBar(
                  text: 'NotesPage',
                  child: Container(),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: GridView.builder(
                    itemCount: state.notes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      NoteModel current = state.notes[index];
                      return GestureDetector(
                        onTap: () {
                          noteBloc.add(
                              NoteToDetailsNavigateEvent(noteModel: current));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: current.title,
                                        style: appstyle(
                                            18, kDark, FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      ReusableText(
                                        text: current.description,
                                        style: appstyle(
                                            16, kDarkGrey, FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        noteBloc.add(NoteDeleteEvent(
                                            noteModel: current));
                                      },
                                      child: Icon(Icons.delete),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else if (state is NoteLodingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
