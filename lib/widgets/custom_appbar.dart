import 'package:atg_assignment3/widgets/app_style.dart';
import 'package:atg_assignment3/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.text, this.actions, required this.child});
  final String? text;
  final List<Widget>? actions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: kLight),
      backgroundColor: kDarkPurple,
      elevation: 0,
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: ReusableText(
        text: text ?? '',
        style: appstyle(20, kLight, FontWeight.w600),
      ),
    );
  }
}
