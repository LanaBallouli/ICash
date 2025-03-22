import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/monthly_target_controller.dart';
import 'package:test_sales/view/widgets/empty_widget.dart';
import '../../app_styles.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/add_monthly_target_bottom_sheet.dart';

class MonthlyTargetScreen extends StatelessWidget {
  const MonthlyTargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MonthlyTargetController monthlyTargetController =
        Provider.of(context, listen: false);

    LangController langController = Provider.of(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEBF1FD),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return AddMonthlyTargetBottomSheet();
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.monthly_target,
          style: AppStyles.getFontStyle(
            langController,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: monthlyTargetController.checkMonthlyTarget(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(AppLocalizations.of(context)!.error_loading_data),
            );
          } else if (snapshot.data == false) {
            return EmptyWidget(
                title: AppLocalizations.of(context)!.empty_monthly_target);
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu<int>(
                      menuStyle: MenuStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.grey[200]!),
                      ),
                      dropdownMenuEntries: List.generate(
                        12,
                        (index) => DropdownMenuEntry(
                          value: index + 1,
                          label:
                              DateFormat('MMMM').format(DateTime(0, index + 1)),
                        ),
                      ),
                      width: 140,
                      label: Text(
                        AppLocalizations.of(context)!.month,
                        textAlign: TextAlign.center,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    DropdownMenu<int>(
                      menuStyle: MenuStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.grey[200]!),
                      ),
                      dropdownMenuEntries: List.generate(
                        3,
                        (index) => DropdownMenuEntry(
                          value: DateTime.now().year + index,
                          label: "${DateTime.now().year + index}",
                        ),
                      ),
                      width: 140,
                      label: Text(
                        AppLocalizations.of(context)!.year,
                        textAlign: TextAlign.center,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const Stack(children: []),
              ],
            );
          }
        },
      ),
    );
  }
}


