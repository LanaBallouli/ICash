import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/login_controller.dart';
import '../../controller/secure_storage_controller.dart';
import 'registration_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final secureStorageProvider = context.read<SecureStorageProvider>();
      final credentials = await secureStorageProvider.loadCredentials();

      final loginProvider = context.read<LoginController>();
      loginProvider.initializeCredentials(
        credentials['email'],
        credentials['password'],
      );
      loginProvider.setRememberMe(credentials['email'] != null);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to initialize: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}