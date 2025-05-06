import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';

import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.add_client,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Center(
            child: Text(
              AppLocalizations.of(context)!.add_client_prompt,
              style: AppStyles.getFontStyle(
                langController,
                color: Colors.black54,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
