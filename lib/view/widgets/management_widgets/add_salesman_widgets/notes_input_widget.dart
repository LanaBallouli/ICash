import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/management_controller.dart';

import '../../../../controller/lang_controller.dart';
import '../../../../controller/login_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class NotesInputWidget extends StatelessWidget {
  final TextEditingController notesController;
  const NotesInputWidget({super.key, required this.notesController});

  @override
  Widget build(BuildContext context) {
    final managementController = context.watch<ManagementController>();
    final langController = Provider.of<LangController>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.notes,
          style: AppStyles.getFontStyle(
            langController,
            color: Color(0xFF6C7278),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        InputWidget(
          height: 100.h,
          borderColor: Color(0xFFEFF0F6),
          textEditingController: notesController,
          obscureText: false,
          keyboardType: TextInputType.text,
          hintText: AppLocalizations.of(context)!.add_notes,
          maxLines: 3,
        ),
      ],
    );
  }
}
