import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/model/users.dart';

import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class AssignedClientsSection extends StatelessWidget {
  final Users users;
  const AssignedClientsSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.assigned_clients,
      leadingIcon: Icons.groups_2_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: users.clients == null || users.clients!.isEmpty
              ? Center(
            child: Text(
              AppLocalizations.of(context)!.no_assigned_clients,
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: users.clients?.length ?? 0,
            itemBuilder: (context, index) {
              final client = users.clients![index];
              return Column(
                children: [
                  InputWidget(
                    textEditingController: TextEditingController(
                        text: client.tradeName ?? "Unknown Client"),
                    label: AppLocalizations.of(context)!.client_name,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward)),
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
