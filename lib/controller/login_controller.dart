import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sales/controller/user_controller.dart';
import '../l10n/app_localizations.dart';
import '../view/screens/registration_screens/email_verification_screen.dart';
import '../view/screens/main_screen.dart';

class LoginController extends ChangeNotifier {
  bool obscureText = true;
  bool obscureText2 = true;
  bool isLoginMode = true;
  bool isLoading = false;
  bool isRememberMeChecked = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void initializeCredentials(String? email, String? password) {
    emailController.text = email ?? '';
    passwordController.text = password ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void setRememberMe(bool value) {
    isRememberMeChecked = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  final Map<String, String?> errors = {
    'email': null,
    'phone': null,
    'password': null,
    'confirmPassword': null,
    'name': null,
    'target': null,
  };

  static final _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final _phoneRegExp = RegExp(r'^(079|077|078)[0-9]{7}$');
  static final _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }

  void validateField({
    required BuildContext context,
    required String field,
    required String? value,
  }) {
    final oldError = errors[field];

    switch (field) {
      case 'email':
        _validateEmail(value, context);
        break;
      case 'phone':
        _validatePhone(value, context);
        break;
      case 'password':
        _validatePassword(value, context);
        break;
      case 'confirmPassword':
        _validateConfirmPassword(value, errors['password'], context);
        break;
      case 'name':
        _validateName(value, context);
        break;
      case 'target':
        _validateTarget(value, context);
        break;
      default:
        errors[field] = null;
    }

    if (errors[field] != oldError) {
      notifyListeners();
    }
  }

  void _validateEmail(String? email, BuildContext context) {
    final newError = email == null || !_emailRegExp.hasMatch(email)
        ? AppLocalizations.of(context)!.email_error
        : null;
    if (errors['email'] != newError) {
      errors['email'] = newError;
      notifyListeners();
    }
  }

  void validateForm({
    required BuildContext context,
    required String email,
    required String password,
    String? confirmPassword,
    String? phone,
    String? name,
  }) {
    final oldErrors = Map<String, String?>.from(errors);

    _validateEmail(email, context);
    _validatePassword(password, context);

    if (!isLoginMode) {
      _validateConfirmPassword(confirmPassword, password, context);
      _validatePhone(phone, context);
      _validateName(name, context);
    }

    if (!_mapsEqual(oldErrors, errors)) {
      notifyListeners();
    }
  }

  bool isFormValid() {
    return !errors.values.any((error) => error != null);
  }

  void _validatePhone(String? phoneNo, BuildContext context) {
    final newError = phoneNo == null || !_phoneRegExp.hasMatch(phoneNo)
        ? AppLocalizations.of(context)!.phone_error
        : null;
    if (errors['phone'] != newError) {
      errors['phone'] = newError;

    }
  }

  void _validatePassword(String? password, BuildContext context) {
    final newError = password == null || !_passwordRegExp.hasMatch(password)
        ? AppLocalizations.of(context)!.password_error
        : null;
    if (errors['password'] != newError) {
      errors['password'] = newError;
    }
  }

  void _validateConfirmPassword(
    String? confirmPassword,
    String? password,
    BuildContext context,
  ) {
    final newError = confirmPassword != password
        ? AppLocalizations.of(context)!.password_mismatch_error
        : null;
    if (errors['confirmPassword'] != newError) {
      errors['confirmPassword'] = newError;
    }
  }

  void _validateName(String? name, BuildContext context) {
    final newError = (name == null || name.isEmpty)
        ? AppLocalizations.of(context)!.name_error
        : name.trim().split(' ').length < 2
            ? AppLocalizations.of(context)!.name_error_2
            : null;

    if (errors['name'] != newError) {
      errors['name'] = newError;
      notifyListeners();
    }
  }

  void validatePhone(String? phoneNo, BuildContext context) {
    if (phoneNo == null || phoneNo.isEmpty) {
      errors['phone'] = AppLocalizations.of(context)!.phone_error;
      notifyListeners();
      return;
    }

    final RegExp phoneRegex = RegExp(r'^(077|078|079)\d{7}$');
    final bool isValid = phoneRegex.hasMatch(phoneNo);

    final newError = isValid ? null : AppLocalizations.of(context)!.phone_error;

    if (errors['phone'] != newError) {
      errors['phone'] = newError;
      notifyListeners();
    }
  }


  void _validateTarget(String? target, BuildContext context) {
    final newError = target == null || double.tryParse(target) == null || double.parse(target) <= 0
        ? AppLocalizations.of(context)!.target_error
        : null;

    if (errors['target'] != newError) {
      errors['target'] = newError;
      notifyListeners();
    }
  }


  void setLoginMode(bool isLogin) {
    isLoginMode = isLogin;
    errors.clear();
    notifyListeners();
  }

  Future<void> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final isVerified = await isEmailVerified();

        if (!isVerified) {
          if (!context.mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
          );
          return;
        }

        if (!context.mounted) return;
        Provider.of<UserController>(context, listen: false).fetchUserName();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    } on AuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.message}')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error}$e')),
      );
    }
  }

  Future<void> createUserProfile({
    required String fullName,
    required String email,
    required String password,
    required String role,
    required String status,
  }) async {
    try {
      await Supabase.instance.client.from('users').insert({
        'full_name': fullName,
        'email': email,
        'password': password,
        'role': role,
        'status': status,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  Future<void> signUpWithEmail(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      print("Starting signup process for email: $email");

      print("Checking if email is already registered...");
      final isEmailUsed = await isEmailAlreadyRegistered(email);
      if (isEmailUsed) {
        print("Email is already registered.");
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.email_already_taken)),
        );
        return;
      }

      print("Email is not registered. Proceeding to create user...");

      final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
      print("Generated user ID: $userId");

      print("Creating user profile in the custom users table...");
      await createUserProfile(
        fullName: name,
        email: email,
        password: password,
        role: 'admin',
        status: 'active',
      );
      print("User profile created successfully.");

      print("Creating user in the auth.users table...");
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name},
      );

      if (authResponse.user != null) {
        print("User created successfully in the auth.users table.");
        if (!context.mounted) return;

        print("Showing success message to the user...");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  AppLocalizations.of(context)!.signup_successful_message)),
        );

        print("Navigating to EmailVerificationScreen...");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
        );
      } else {
        print("Failed to create user in the auth.users table.");
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.signup_failed)),
        );
      }
    } on AuthException catch (e) {
      print("AuthException occurred: ${e.message}");
      if (!context.mounted) return;

      final message = e.message.contains('User already registered')
          ? AppLocalizations.of(context)!.email_already_taken
          : "${AppLocalizations.of(context)!.signup_failed} ${e.message}";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("Unexpected exception occurred: $e");
      if (!context.mounted) return;

      // Handle unexpected exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error} $e')),
      );
    }
  }

  bool _mapsEqual(Map<String, String?> a, Map<String, String?> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    final response = await Supabase.instance.client
        .from('users')
        .select('id')
        .eq('email', email)
        .limit(1);
    return response.isNotEmpty;
  }

  Future<bool> isEmailVerified() async {
    try {
      final response = await Supabase.instance.client.auth.getUser();

      final user = response.user;

      return user?.emailConfirmedAt != null;
    } catch (e) {
      print("Error checking email verification status: $e");
      return false;
    }
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
  }
}
