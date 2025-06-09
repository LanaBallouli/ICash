import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sales/controller/address_controller.dart';
import 'package:test_sales/controller/camera_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/invoice_controller.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/location_controller.dart';
import 'package:test_sales/controller/login_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/controller/secure_storage_controller.dart';
import 'package:test_sales/controller/user_controller.dart';
import 'package:test_sales/controller/visit_controller.dart';
import 'package:test_sales/repository/address_repository.dart';
import 'package:test_sales/repository/client_repository.dart';
import 'package:test_sales/repository/invoice_repository.dart';
import 'package:test_sales/repository/product_repository.dart';
import 'package:test_sales/repository/salesman_repository.dart';
import 'package:test_sales/repository/visit_repository.dart';
import 'package:test_sales/supabase_api.dart';
import 'package:test_sales/view/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: 'https://hjvobotsjdmmoscfgqtx.supabase.co',
      anonKey:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhqdm9ib3RzamRtbW9zY2ZncXR4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NzYwMTgsImV4cCI6MjA1MzA1MjAxOH0.OdO2l43Uqd8tqBRN4LUoz8fVmgLgYy6nu-W0RW7lYHA',
    );
  } catch (e) {
    print("Supabase init failed: $e");
    runApp(const MyAppError());
    return;
  }
  final supabase = Supabase.instance.client;
  final supabaseApi = SupabaseApi(supabase);
  final addressRepository = AddressRepository(supabaseApi);
  final clientRepository = ClientRepository(supabaseApi);
  final salesmanRepository = SalesmanRepository(supabaseApi);
  final invoiceRepository = InvoiceRepository(supabaseApi);
  final visitRepository = VisitRepository(supabaseApi);
  final productRepository = ProductRepository(supabaseApi);

  final langController = LangController();
  await langController.initSharedPreferences();

  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoginController()),
            ChangeNotifierProvider(create: (_) => ManagementController()),
            ChangeNotifierProvider(create: (_) => CameraController()),
            ChangeNotifierProvider(create: (_) => SecureStorageProvider()),
            ChangeNotifierProvider(create: (_) => UserController()),
            ChangeNotifierProvider(create: (_) => LocationController()),
            ChangeNotifierProvider(create: (_) => LangController()),
            ChangeNotifierProvider(create: (_) => ClientsController(clientRepository)),
            ChangeNotifierProvider(create: (_) => SalesmanController(salesmanRepository)),
            ChangeNotifierProvider(create: (_) => ProductController(productRepository)),
            ChangeNotifierProvider(create: (_) => VisitsController(visitRepository)),
            ChangeNotifierProvider(create: (_) => InvoicesController(invoiceRepository)),
            ChangeNotifierProvider(create: (_) => AddressController(addressRepository)),
          ],
          child: MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context);

    return MaterialApp(
      locale: langController.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class MyAppError extends StatelessWidget {
  const MyAppError({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Failed to load app.'),
        ),
      ),
    );
  }
}