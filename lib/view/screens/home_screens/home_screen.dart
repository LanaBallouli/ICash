import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/view/screens/home_screens/cash_invoice_screen.dart';
import 'package:test_sales/view/screens/home_screens/debt_invoice_screen.dart';
import 'package:test_sales/view/screens/home_screens/monthly_target_screen.dart';
import 'package:test_sales/view/widgets/home_widgets/card_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/home_widgets/circle.dart';
import '../../widgets/home_widgets/button_widget.dart';
import '../../widgets/home_widgets/progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextEditingController = TextEditingController();
    int numActiveRep = 22;
    int numDebts = 44;
    final langController = Provider.of<LangController>(context);

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
                  const SizedBox(height: 10),
                  InputWidget(
                    textEditingController: searchTextEditingController,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.search),
                    label: AppLocalizations.of(context)!.search,
                  ),
                  const SizedBox(height: 20),
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
                        ProgressCard(
                          title: AppLocalizations.of(context)!.daily_sales,
                          date: 'May 30, 2022',
                          cardColor: const Color(0xFF10376A),
                          progressColor: Colors.black,
                          textColor: Colors.white,
                          langController: langController,
                          icon: Icons.incomplete_circle_rounded,
                        ),
                        ProgressCard(
                          title: AppLocalizations.of(context)!.monthly_target,
                          date: 'May 30, 2022',
                          textColor: Colors.black,
                          progressColor: Color(0xFF0B2B4A),
                          langController: langController,
                          icon: Icons.safety_check,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MonthlyTargetScreen(),
                              ),
                            );
                          },
                        ),
                        CardWidget(
                          title: AppLocalizations.of(context)!.active_rep,
                          date: 'May 30, 2022',
                          langController: langController,
                          textColor: Colors.black,
                          icon: Icons.ac_unit,
                          widget: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.num_active_rep,
                                style: AppStyles.getFontStyle(
                                  langController,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${numActiveRep.toString()} / 50",
                                style: AppStyles.getFontStyle(
                                  langController,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CardWidget(
                          title: AppLocalizations.of(context)!.debts,
                          date: 'May 30, 2022',
                          langController: langController,
                          textColor: Colors.black,
                          icon: Icons.access_alarm,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.total_debts,
                                style: AppStyles.getFontStyle(
                                  langController,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${numDebts.toString()} د.أ.",
                                style: AppStyles.getFontStyle(
                                  langController,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Circle(
                                name: AppLocalizations.of(context)!
                                    .create_invoice,
                                icon: "assets/images/bills.png",
                                size: 50,
                                onPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AlertDialog(
                                            backgroundColor: Colors.white,
                                            alignment: Alignment.topCenter,
                                            title: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Choose invoice type",
                                                style: AppStyles.getFontStyle(
                                                  langController,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              ButtonWidget(
                                                buttonName: "Cash",
                                                buttonColor: Colors.white,
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CashInvoiceScreen(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              ButtonWidget(
                                                buttonName: "Debt",
                                                buttonColor: Colors.white,
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DebtInvoiceScreen(),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Circle(
                                name: AppLocalizations.of(context)!
                                    .account_statement,
                                icon: "assets/images/accept.png",
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Circle(
                                name:
                                    AppLocalizations.of(context)!.accept_debts,
                                icon: "assets/images/accept.png",
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Circle(
                                name: AppLocalizations.of(context)!.set_path,
                                icon: "assets/images/google-maps.png",
                                size: 50,
                              ),
                            ),
                          ],
                        ),
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "المهام",
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
                  ButtonWidget(
                    buttonName: "buttonName",
                    buttonColor: Colors.black12,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    buttonName: "buttonName",
                    buttonColor: Colors.black12,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    buttonName: "buttonName",
                    buttonColor: Colors.black12,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
