import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../model/region.dart';

class ManagementController extends ChangeNotifier {
  int selectedIndex = 0;
  String? selectedCategory;
  bool obscureText = false;
  Region? selectedRegion;
  String? selectedType;

  void setSelectedRegion(Region? value, BuildContext context) {
    selectedRegion = value;
    validateField(field: 'region', value: value, context: context);
    notifyListeners();
  }

  void setSelectedType(String? value, BuildContext context) {
    selectedType = value;
    validateField(field: 'type', value: value, context: context);
    notifyListeners();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController monthlyTargetController = TextEditingController();
  final TextEditingController dailyTargetController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final Map<String, String?> errors = {
    'email': null,
    'phone': null,
    'password': null,
    'name': null,
    'target': null,
    'daily_target': null,
    'region': null,
    'type': null,
  };

  void clearErrors() {
    errors.updateAll((key, value) => null);
    notifyListeners();
  }

  static final _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final _phoneRegExp = RegExp(r'^(079|077|078)[0-9]{7}$');
  static final _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  void _validateEmail(String? email, BuildContext context) {
    final newError = email == null || !_emailRegExp.hasMatch(email)
        ? AppLocalizations.of(context)!.email_error
        : null;
    if (errors['email'] != newError) {
      errors['email'] = newError;
      notifyListeners();
    }
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

  void _validateTarget(String? target, BuildContext context) {
    final newError = target == null ||
            double.tryParse(target) == null ||
            double.parse(target) <= 0
        ? AppLocalizations.of(context)!.target_error
        : null;

    if (errors['target'] != newError) {
      errors['target'] = newError;
      notifyListeners();
    }
  }

  void _validateDailyTarget(String? target, BuildContext context) {
    final newError = target == null ||
            double.tryParse(target) == null ||
            double.parse(target) <= 0
        ? AppLocalizations.of(context)!.target_error
        : null;

    if (errors['daily_target'] != newError) {
      errors['daily_target'] = newError;
      notifyListeners();
    }
  }

  void _validateType(String? type, BuildContext context) {
    final newError = type == null || type.isEmpty
        ? AppLocalizations.of(context)!.type_error
        : null;

    if (errors['type'] != newError) {
      errors['type'] = newError;
      notifyListeners();
    }
  }

  void _validateRegion(Region? region, BuildContext context) {
    final newError = region == null
        ? AppLocalizations.of(context)!.region_error
        : null;

    if (errors['region'] != newError) {
      errors['region'] = newError;
      notifyListeners();
    }
  }

  void validateForm(
      {required BuildContext context,
      required String email,
      required String password,
      required String? phone,
      required String? name,
      required String? monthlyTarget,
      required String? dailyTarget,
      required String? type,
      required Region? region}) {
    final oldErrors = Map<String, String?>.from(errors);

    _validateEmail(email, context);
    _validatePassword(password, context);
    _validatePhone(phone, context);
    _validateName(name, context);
    _validateTarget(monthlyTarget, context);
    _validateDailyTarget(dailyTarget, context);
    _validateType(type, context);
    _validateRegion(region, context);

    if (!_mapsEqual(oldErrors, errors)) {
      notifyListeners();
    }
  }

  bool _mapsEqual(Map<String, String?> a, Map<String, String?> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  void validateField({
    required BuildContext context,
    required String field,
    required dynamic value,
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
      case 'name':
        _validateName(value, context);
        break;
      case 'target':
        _validateTarget(value, context);
        break;
      case 'daily_target':
        _validateDailyTarget(value, context);
        break;
      case 'type':
        _validateType(value, context);
        break;
      case 'region':
        _validateRegion(value, context);
        break;

      default:
        errors[field] = null;
    }

    if (errors[field] != oldError) {
      notifyListeners();
    }
  }

  bool isFormValid() {
    return !errors.values.any((error) => error != null);
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    if (selectedCategory != category) {
      selectedCategory = category;
      notifyListeners();
    }
  }

  void updateSelectedIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }



  void clearFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneNumberController.clear();
    selectedRegion = null;
    selectedType = null;
    monthlyTargetController.clear();
    dailyTargetController.clear();
    notesController.clear();
  }
}
