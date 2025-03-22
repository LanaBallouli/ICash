import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_styles.dart';
import '../../controller/lang_controller.dart';
import '../../l10n/app_localizations.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        height: 500,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF1FD),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.notifications,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListTile(
                title: Text("data"),
                subtitle: Text("data"),
                leading: Icon(
                  Icons.access_alarm,
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
