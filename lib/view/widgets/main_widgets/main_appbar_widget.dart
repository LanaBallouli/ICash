import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/view/widgets/main_widgets/notification_widget.dart';

import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';

class MainAppbarWidget extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const MainAppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context);

    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: AppStyles.getFontStyle(
          langController,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      actions: [NotificationWidget()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
