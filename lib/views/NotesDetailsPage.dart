import 'package:atg_assignment3/controllers/bloc/note_bloc.dart';
import 'package:atg_assignment3/models/note_models.dart';
import 'package:atg_assignment3/widgets/app_style.dart';
import 'package:atg_assignment3/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import '../widgets/custom_appbar.dart';

class NotesDetailsPage extends StatelessWidget {
  final NoteModel noteModel;
  NotesDetailsPage({super.key,required this.noteModel});
  NoteBloc noteBloc = NoteBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      bloc: noteBloc,
      listenWhen: (previous, current) => current is NoteActionState,
      buildWhen: (previous, current) => current is! NoteActionState,
      listener: (context, state) {
        if(state is NoteFromDetailsNavigateState){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: 'NotesDetails',
              child: InkWell(
                onTap: () {
                  noteBloc.add(NoteFromDetailsNavigateEvent());
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: ReusableText(
                    text: noteModel.title,
                    style: appstyle(18, kDark, FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: ReusableText(
                    text:
                        noteModel.description,
                    maxLines: 10,
                    style: appstyle(16, kDarkGrey, FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
