import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/more_details_widget.dart';

import '../../../controller/lang_controller.dart';

class SalesmenMoreDetailsScreen extends StatelessWidget {
  final Users users;

  const SalesmenMoreDetailsScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.more_details,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFE7E7E7),
                    foregroundImage: AssetImage(
                        users.imageUrl ?? "assets/images/default_image.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                  child: Text(
                users.fullName ?? "name",
                style: AppStyles.getFontStyle(langController,
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
              )),
              SizedBox(height: 15.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.profile,
                leadingIcon: Icons.person_outline_rounded,
                initExpanded: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.fullName),
                      obscureText: false,
                      label: "Name",
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.email),
                      obscureText: false,
                      label: "Email",
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.phone.toString()),
                      obscureText: false,
                      label: "Phone",
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.role),
                      obscureText: false,
                      label: "Role",
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.region),
                      obscureText: false,
                      label: "Region",
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.status),
                      obscureText: false,
                      label: "Status",
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InputWidget(
                      textEditingController: TextEditingController(text: users.createdAt.toString()),
                      obscureText: false,
                      label: "Joining Date",
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.performance,
                leadingIcon: Icons.assessment_outlined,
                initExpanded: false,
                children: [],
              ),
              SizedBox(height: 10.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.recent_activity_log,
                leadingIcon: Icons.access_time,
                initExpanded: false,
                children: [],
              ),
              SizedBox(height: 10.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.assigned_clients,
                leadingIcon: Icons.groups_2_outlined,
                initExpanded: false,
                children: [],
              ),
              SizedBox(height: 10.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.sales_reports,
                leadingIcon: Icons.file_copy_outlined,
                initExpanded: false,
                children: [],
              ),
              SizedBox(height: 10.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.attendance_and_work_hours,
                leadingIcon: Icons.timeline,
                initExpanded: false,
                children: [],
              ),
              SizedBox(height: 10.h),
              MoreDetailsWidget(
                title: AppLocalizations.of(context)!.feedback,
                leadingIcon: Icons.location_history_outlined,
                initExpanded: false,
                children: [],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
