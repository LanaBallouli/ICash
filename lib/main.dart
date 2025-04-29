import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/Invoice_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/login_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/controller/secure_storage_controller.dart';
import 'package:test_sales/controller/monthly_target_controller.dart';
import 'package:test_sales/controller/user_provider.dart';
import 'package:test_sales/view/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Supabase.initialize(
    url: 'https://hjvobotsjdmmoscfgqtx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhqdm9ib3RzamRtbW9zY2ZncXR4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NzYwMTgsImV4cCI6MjA1MzA1MjAxOH0.OdO2l43Uqd8tqBRN4LUoz8fVmgLgYy6nu-W0RW7lYHA',
  );

  await GoogleFonts.config;
  final langController = LangController();
  await langController.initSharedPreferences();

  runApp(

   ScreenUtilInit(
     designSize: Size(414, 896),
     builder: (context, child) {
       return  MultiProvider(
         providers: [
           ChangeNotifierProvider(create: (_) => LoginProvider()),
           ChangeNotifierProvider(create: (_) => MonthlyTargetController()),
           ChangeNotifierProvider(create: (_) => SecureStorageProvider()),
           ChangeNotifierProvider(create: (_) => UserProvider()),
           ChangeNotifierProvider(create: (_) => ClientsController()),
           ChangeNotifierProvider(create: (context) => InvoiceController(
             clientsController: context.read<ClientsController>(),
           ),),
           ChangeNotifierProvider(create: (_) => ProductController()),
           ChangeNotifierProvider<LangController>(create: (_) => langController),
         ],
         child: MyApp(),
       );
     },
   )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
