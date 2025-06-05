import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../../model/monthly_target.dart';
import '../main_widgets/input_widget.dart';

class AddMonthlyTargetBottomSheet extends StatelessWidget {
  final TextEditingController _targetAmountController = TextEditingController();

  AddMonthlyTargetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

    UserController userProvider = Provider.of(context, listen: false);

    // Generate years dynamically
    List<int> years = List.generate(10, (index) => DateTime.now().year + index);

    LangController langController = Provider.of(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(
        bottom:
        MediaQuery.of(context).viewInsets.bottom, // Handle keyboard overlap
      ),
      child: Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF1FD),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.add_goal,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.fill_in,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Consumer<MonthlyTargetController>(
              //   builder: (context, monthlyTargetController, child) {
              //     return DropdownMenu<int>(
              //       menuStyle: MenuStyle(
              //         backgroundColor:
              //         WidgetStateProperty.all<Color>(Colors.white),
              //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //         ),
              //         fixedSize:
              //         WidgetStateProperty.all<Size>(const Size(140, 200)),
              //       ),
              //       dropdownMenuEntries: List.generate(
              //         12,
              //             (index) => DropdownMenuEntry(
              //           value: index + 1,
              //           label:
              //           DateFormat('MMMM').format(DateTime(0, index + 1)),
              //         ),
              //       ),
              //       inputDecorationTheme: InputDecorationTheme(
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(40),
              //           borderSide:
              //           const BorderSide(color: Colors.grey, width: 0.5),
              //         ),
              //       ),
              //       width: 230,
              //       leadingIcon: const Icon(Icons.date_range_outlined),
              //       label: Text(
              //         AppLocalizations.of(context)!.month,
              //         textAlign: TextAlign.center,
              //         style: AppStyles.getFontStyle(
              //           langController,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //         ),
              //       ),
              //       onSelected: (int? value) {
              //         monthlyTargetController.setSelectedMonth(value.toString());
              //       },
              //     );
              //   },
              // ),
              const SizedBox(height: 15),
              // Consumer<MonthlyTargetController>(
              //   builder: (context, monthlyTargetController, child) {
              //     return DropdownMenu<String>(
              //       menuStyle: MenuStyle(
              //         backgroundColor:
              //         WidgetStateProperty.all<Color>(Colors.white),
              //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //         ),
              //         fixedSize:
              //         WidgetStateProperty.all<Size>(const Size(140, 140)),
              //       ),
              //       dropdownMenuEntries: years
              //           .map((year) => DropdownMenuEntry(
              //           value: year.toString(), label: year.toString()))
              //           .toList(),
              //       inputDecorationTheme: InputDecorationTheme(
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(40),
              //           borderSide:
              //           const BorderSide(color: Colors.grey, width: 0.5),
              //         ),
              //       ),
              //       width: 230,
              //       leadingIcon: const Icon(Icons.date_range_outlined),
              //       label: Text(
              //         AppLocalizations.of(context)!.year,
              //         textAlign: TextAlign.center,
              //         style: AppStyles.getFontStyle(
              //           langController,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //         ),
              //       ),
              //       onSelected: (String? value) {
              //         monthlyTargetController.setSelectedYear(value);
              //       },
              //     );
              //   },
              // ),
              const SizedBox(height: 15),
              InputWidget(
                textEditingController: _targetAmountController,
                obscureText: false,
                prefixIcon: const Icon(Icons.attach_money_rounded),
                label: AppLocalizations.of(context)!.goal_amount,
                keyboardType: TextInputType.number,
                backgroundColor: Colors.white,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     fixedSize:
                  //     WidgetStateProperty.all<Size>(const Size(110, 50)),
                  //     backgroundColor: WidgetStateProperty.all<Color>(
                  //         const Color(0xFF170F4C)),
                  //   ),
                  //   // onPressed: () async {
                  //   //   // Validate inputs
                  //   //   if (monthlyTargetController.selectedYear!.isEmpty ||
                  //   //       monthlyTargetController.selectedMonth!.isEmpty ||
                  //   //       _targetAmountController.text.isEmpty) {
                  //   //     ScaffoldMessenger.of(context).showSnackBar(
                  //   //       SnackBar(content: Text("error_empty_field")),
                  //   //     );
                  //   //     return;
                  //   //   }
                  //   //
                  //   //   final monthlyTarget = MonthlyTarget(
                  //   //     startDate: monthlyTargetController.selectedMonth,
                  //   //     endDate: monthlyTargetController.selectedYear,
                  //   //     targetAmount:
                  //   //     int.tryParse(_targetAmountController.text),
                  //   //     createdAt: DateTime.now().toIso8601String(),
                  //   //     createdBy: userProvider.userId,
                  //   //     progress: 0,
                  //   //   );
                  //   //
                  //   //   // Insert data into Supabase
                  //   //   try {
                  //   //     await monthlyTargetController
                  //   //         .insertMonthlyTarget(monthlyTarget);
                  //   //     showDialog(
                  //   //       context: context,
                  //   //       builder: (BuildContext context) {
                  //   //         return AlertDialog(
                  //   //
                  //   //           backgroundColor: Color(0xFFFAFEF9),
                  //   //           icon: Image.asset(
                  //   //             'assets/images/success.png',
                  //   //             height: 70,
                  //   //             width: 70,
                  //   //           ),
                  //   //           title: Text(
                  //   //             AppLocalizations.of(context)!.success_target,
                  //   //             style: AppStyles.getFontStyle(
                  //   //               langController,
                  //   //               fontSize: 16,
                  //   //               fontWeight: FontWeight.w500,
                  //   //               color: Colors.black,
                  //   //             ),
                  //   //           ),
                  //   //           actions: [
                  //   //             Center(
                  //   //               child: ElevatedButton(
                  //   //                 style: ButtonStyle(
                  //   //                   fixedSize: WidgetStateProperty.all<Size>(
                  //   //                       const Size(110, 50)),
                  //   //                   backgroundColor:
                  //   //                   WidgetStateProperty.all<Color>(
                  //   //                       const Color(0xFF170F4C)),
                  //   //                 ),
                  //   //                 onPressed: () {
                  //   //                   Navigator.pop(context);
                  //   //                 },
                  //   //                 child: Text(
                  //   //                   AppLocalizations.of(context)!.ok,
                  //   //                   style: AppStyles.getFontStyle(
                  //   //                     langController,
                  //   //                     fontSize: 16,
                  //   //                     fontWeight: FontWeight.w500,
                  //   //                     color: Colors.white,
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //             ),
                  //   //           ],
                  //   //         );
                  //   //       },
                  //   //     );
                  //   //   } catch (error) {
                  //   //     ScaffoldMessenger.of(context).showSnackBar(
                  //   //       SnackBar(content: Text("error_saving_data")),
                  //   //     );
                  //   //   }
                  //   // },
                  //   child: Text(
                  //     AppLocalizations.of(context)!.save,
                  //     style: AppStyles.getFontStyle(
                  //       langController,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                      WidgetStateProperty.all<Size>(const Size(110, 50)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF170F4C)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: AppStyles.getFontStyle(
                        langController,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}