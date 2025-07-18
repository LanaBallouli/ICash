import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/view/widgets/home_widgets/card_widget.dart';
import 'package:test_sales/view/widgets/home_widgets/daily_sales_widget.dart';

import '../../../app_constants.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/visit_controller.dart';
import '../../../view/widgets/main_widgets/custom_button_widget.dart';
import '../../../view/widgets/main_widgets/main_appbar_widget.dart';

class SalesmanHomeScreen extends StatelessWidget {
  const SalesmanHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context);

    return Scaffold(
      appBar: MainAppbarWidget(
        title: local.main_screen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<SalesmanController>(
                builder: (context, salesmanCtrl, _) {
                  final salesman = salesmanCtrl.currentSalesman;

                  return CardWidget(
                    title: local.profile,
                    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    langController: langCtrl,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (salesman!.imageUrl.isNotEmpty)
                          CircleAvatar(
                            radius: 40.r,
                            backgroundImage: AssetImage("assets/images/default_image.png"),
                          )
                        else
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person, size: 30.sp),
                          ),
                        SizedBox(height: 10.h),
                        Text(
                          "${local.full_name}: ${salesman.fullName}",
                          style: AppStyles.getFontStyle(langCtrl, fontSize: 16.sp),
                        ),
                        Text(
                          "${local.email}: ${salesman.email}",
                          style: AppStyles.getFontStyle(langCtrl, fontSize: 14.sp),
                        ),
                        Text(
                          "${local.phone}: ${salesman.phone}",
                          style: AppStyles.getFontStyle(langCtrl, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

              DailySalesWidget(),

              SizedBox(height: 20.h),


              SizedBox(height: 20.h),

              Consumer<VisitsController>(
                builder: (context, visitsCtrl, _) {

                  return CardWidget(
                    title: local.recent_activity,
                    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    langController: langCtrl,
                    widget: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: visitsCtrl.visits.length,
                      itemBuilder: (context, index) {
                        final visit = visitsCtrl.visits[index];
                        return RecentActivityCard(
                          activityType: "Visit",
                          timestamp: visit.visitDate,
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

              // 🔹 Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      title: local.create_invoice,
                      color: AppConstants.primaryColor2,
                      titleColor: Colors.white,
                      onPressed: () => Navigator.pushNamed(context, '/create-invoice'),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButtonWidget(
                      title: local.view_clients,
                      color: AppConstants.buttonColor,
                      titleColor: Colors.white,
                      onPressed: () => Navigator.pushNamed(context, '/clients'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RecentActivityCard extends StatelessWidget {
  final String activityType;
  final DateTime timestamp;

  const RecentActivityCard({
    super.key,
    required this.activityType,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppConstants.primaryColor2.withOpacity(0.2),
        child: Text(
          activityType[0],
          style: TextStyle(color: AppConstants.primaryColor2),
        ),
      ),
      subtitle: Text(
        DateFormat('yyyy-MM-dd HH:mm').format(timestamp),
        style: AppStyles.getFontStyle(langCtrl, fontSize: 12.sp),
      ),
    );
  }
}