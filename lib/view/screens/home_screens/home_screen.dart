import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/invoice_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/view/screens/home_screens/cash_invoice_screen.dart';
import 'package:test_sales/view/screens/home_screens/debt_invoice_screen.dart';
import 'package:test_sales/view/widgets/home_widgets/card_widget.dart';
import 'package:test_sales/view/widgets/home_widgets/debt_calculator_widget.dart';
import 'package:test_sales/view/widgets/home_widgets/top_salesman_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/sales_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/home_widgets/circle.dart';
import '../../widgets/home_widgets/button_widget.dart';
import '../../widgets/home_widgets/daily_sales_widget.dart';
import '../../widgets/home_widgets/monthly_sales_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context);
    final invoiceController = Provider.of<InvoicesController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          MainAppbarWidget(title: AppLocalizations.of(context)!.main_screen),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserController>(
                    builder: (context, userProvider, child) {
                      return Text(
                        "${AppLocalizations.of(context)!.hi} ${userProvider.currentUser?.fullName ?? ''}!",
                        style: AppStyles.getFontStyle(
                          langController,
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  Divider(color: Color(0xFFe2e2e2)),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.dashboard,
                    style: AppStyles.getFontStyle(
                      langController,
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.95,
                      children: [
                        DailySalesWidget(),
                        Consumer<SalesController>(
                          builder: (context, salesCtrl, child) {
                            double currentSales = salesCtrl.monthlySales;
                            double monthlyTarget = salesCtrl.monthlyTarget;

                            return MonthlySalesWidget(
                              currentSales: currentSales,
                              monthlyTarget: monthlyTarget,
                            );
                          },
                        ),
                        DebtCardWidget(invoices: invoiceController.invoices),
                        Consumer<SalesmanController>(
                          builder: (context, salesmanController, child) {
                            return TopSalesmanWidget(
                                salesmen: salesmanController.salesMen);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFFFAFAFA),
                  border: Border.all(width: 0.5, color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF363535).withOpacity(0.16),
                      blurRadius: 6,
                      offset: const Offset(4, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.quick_access,
                        style: AppStyles.getFontStyle(
                          langController,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomButtonWidget(
                            title: AppLocalizations.of(context)!.create_invoice,
                            icon: Icons.receipt_long_outlined,
                            color: AppConstants.buttonColor,
                            titleColor: Colors.black,
                          ),
                          SizedBox(height: 16.h),
                          CustomButtonWidget(
                            title:
                                AppLocalizations.of(context)!.account_statement,
                            icon: Icons.account_balance_wallet_outlined,
                          ),
                          SizedBox(height: 16.h),
                          CustomButtonWidget(
                            title: AppLocalizations.of(context)!.assign_tasks,
                            icon: Icons.assignment_turned_in_outlined,
                            color: AppConstants.buttonColor,
                            titleColor: Colors.black,
                          ),
                          SizedBox(height: 16.h),
                          CustomButtonWidget(
                            title: AppLocalizations.of(context)!.accept_debts,
                            icon: Icons.pending_actions,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
