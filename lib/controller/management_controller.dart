import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../model/client.dart';
import '../model/invoice.dart';
import '../model/monthly_sales.dart';
import '../model/product.dart';
import '../model/region.dart';
import '../model/users.dart';
import '../model/visit.dart';

class ManagementController extends ChangeNotifier {
  int selectedIndex = 0;
  String? selectedCategory;
  final List<Users> fav = [];
  List<Users> salesMen = [
    Users(
      id: 1,
      fullName: "John Doe",
      email: "john.doe@example.com",
      phone: "1234567890",
      role: "Salesman",
      type: "Cash",
      password: "@Lana123",
      status: "Active",
      totalSales: 50000.0,
      closedDeals: 15,
      monthlyTarget: 90.0,
      region: Region(name: "Amman"),
      visits: [
        Visit(visitDate: DateTime(2023, 10, 1)),
        Visit(visitDate: DateTime(2023, 10, 15)),
      ],
      invoices: [
        Invoice(
          products: [
            Product(price: 100.0, quantity: 3, ),
            Product(price: 200.0),
          ],
        ),
      ],
      monthlySales: [
        MonthlySales(totalSales: 10000.0),
        MonthlySales(totalSales: 15000.0),
      ],
      clients: [
        Client(tradeName: "Client A"),
        Client(tradeName: "Client B"),
      ],
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 10, 1),
    ),
    Users(
      type: "Cash",
      password: "@Lana123",
      id: 2,
      fullName: "Jane Smith",
      email: "jane.smith@example.com",
      phone: "9876543210",
      role: "Salesman",
      status: "Active",
      totalSales: 75000.0,
      closedDeals: 20,
      monthlyTarget: 95.0,
      region: Region(name: "Amman"),
      // imageUrl: "assets/images/jane_smith.jpg",
      visits: [
        Visit(visitDate: DateTime(2023, 9, 20)),
        Visit(visitDate: DateTime(2023, 10, 5)),
      ],
      invoices: [
        Invoice(
          products: [
            Product(price: 300.0),
            Product(price: 400.0),
          ],
        ),
      ],
      monthlySales: [
        MonthlySales(totalSales: 20000.0),
        MonthlySales(totalSales: 25000.0),
      ],
      clients: [
        Client(tradeName: "Client C"),
        Client(tradeName: "Client D"),
      ],
      createdAt: DateTime(2023, 2, 1),
      updatedAt: DateTime(2023, 10, 5),
    ),
    Users(
      id: 3,
      type: "Cash",
      password: "@Lana123",
      fullName: "Alice Johnson",
      email: "alice.johnson@example.com",
      phone: "5555555555",
      role: "Salesman",
      status: "Inactive",
      totalSales: 30000.0,
      closedDeals: 10,
      monthlyTarget: 80.0,
      region: Region(name: "Amman"),
      // imageUrl: "assets/images/alice_johnson.jpg",
      visits: [
        Visit(visitDate: DateTime(2023, 8, 10)),
        Visit(visitDate: DateTime(2023, 9, 1)),
      ],
      invoices: [
        Invoice(
          products: [
            Product(price: 500.0, id: 1),
            Product(price: 600.0),
          ],
        ),
      ],
      monthlySales: [
        MonthlySales(totalSales: 12000.0),
        MonthlySales(totalSales: 18000.0),
      ],
      clients: [
        Client(tradeName: "Client E"),
        Client(tradeName: "Client F"),
      ],
      createdAt: DateTime(2023, 3, 1),
      updatedAt: DateTime(2023, 9, 10),
    ),
  ];
  Users? selectedUser;
  bool obscureText = false;
  String? selectedRegion;
  String? selectedType;

  void setSelectedRegion(String? value, BuildContext context) {
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
  final TextEditingController targetController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final Map<String, String?> errors = {
    'email': null,
    'phone': null,
    'password': null,
    'name': null,
    'target': null,
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

  void _validateType(String? type, BuildContext context) {
    final newError = type == null || type.isEmpty
        ? AppLocalizations.of(context)!.type_error
        : null;

    if (errors['type'] != newError) {
      errors['type'] = newError;
      notifyListeners();
    }
  }

  void _validateRegion(String? region, BuildContext context) {
    final newError = region == null || region.isEmpty
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
      required String? target,
      required String? type,
      required String? region}) {
    final oldErrors = Map<String, String?>.from(errors);

    _validateEmail(email, context);
    _validatePassword(password, context);
    _validatePhone(phone, context);
    _validateName(name, context);
    _validateTarget(target, context);
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
      case 'name':
        _validateName(value, context);
        break;
      case 'target':
        _validateTarget(value, context);
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

  void addNewUser(Users user) {
    salesMen.add(user);
    notifyListeners();
  }

  updateUser({
    required Users user,
    required int index,
  }) {
    salesMen[index] = user;
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

  void deleteUser(Users user) {
    if (salesMen.contains(user)) {
      salesMen.remove(user);
      notifyListeners();
    }
  }

  void toggleFavourite(BuildContext context, Users user) {
    if (fav.contains(user)) {
      fav.remove(user);
    } else {
      fav.add(user);
    }
    notifyListeners();
  }

  bool isFavourite(Users user) {
    if (fav.contains(user)) {
      return true;
    } else {
      return false;
    }
  }

  List<dynamic> getFilteredItems(
      BuildContext context, String? selectedCategory) {
    final localizations = AppLocalizations.of(context)!;

    if (selectedCategory == localizations.sales_men) {
      return salesMen;
    } else if (selectedCategory == localizations.clients) {
      return [];
    } else if (selectedCategory == localizations.products) {
      return [];
    } else {
      return [];
    }
  }


  void clearFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneNumberController.clear();
    selectedRegion = null;
    selectedType = null;
    targetController.clear();
    notesController.clear();
  }
}
