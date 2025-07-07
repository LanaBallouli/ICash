import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/invoice_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/view/widgets/home_widgets/debt_calculator_widget.dart';
import 'package:test_sales/view/widgets/home_widgets/top_salesman_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/sales_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/home_widgets/daily_sales_widget.dart';
import '../../widgets/home_widgets/monthly_sales_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context);
    final invoiceController = Provider.of<InvoicesController>(context);
    final salesCtrl = Provider.of<SalesController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          MainAppbarWidget(title: AppLocalizations.of(context)!.main_screen),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserController>(
              builder: (context, userProvider, _) {
                final fullName = userProvider.currentUser?.fullName ??
                    AppLocalizations.of(context)!.user;

                return Text(
                  "${AppLocalizations.of(context)!.hi} $fullName!",
                  style: AppStyles.getFontStyle(
                    langController,
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            Divider(color: Color(0xFFe2e2e2), height: 30.h),
            Text(
              AppLocalizations.of(context)!.dashboard,
              style: AppStyles.getFontStyle(
                langController,
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                childAspectRatio: 0.95,
                children: [
                  DailySalesWidget(),
                  MonthlySalesWidget(
                    currentSales: salesCtrl.monthlySales,
                    monthlyTarget: salesCtrl.monthlyTarget,
                  ),
                  DebtCardWidget(invoices: invoiceController.invoices),
                  Consumer<SalesmanController>(
                    builder: (context, salesmanController, _) {
                      return TopSalesmanWidget(
                        salesmen: salesmanController.salesMen,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              AppLocalizations.of(context)!.quick_access,
              style: AppStyles.getFontStyle(
                langController,
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: const Color(0xFFFAFAFA),
                border: Border.all(width: 0.5, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF363535).withOpacity(0.16),
                    blurRadius: 6.r,
                    offset: Offset(4, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.create_invoice,
                      icon: Icons.receipt_long_outlined,
                      color: AppConstants.buttonColor,
                      titleColor: Colors.black,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/invoice-create'),
                    ),
                    SizedBox(height: 16.h),
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.account_statement,
                      icon: Icons.account_balance_wallet_outlined,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/statements'),
                    ),
                    SizedBox(height: 16.h),
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.assign_tasks,
                      icon: Icons.assignment_turned_in_outlined,
                      color: AppConstants.buttonColor,
                      titleColor: Colors.black,
                      onPressed: () => Navigator.pushNamed(context, '/tasks'),
                    ),
                    SizedBox(height: 16.h),
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.accept_debts,
                      icon: Icons.pending_actions,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
