import 'package:flutter/cupertino.dart';
import 'package:test_sales/model/client.dart';
import '../l10n/app_localizations.dart';
import '../model/region.dart';
import '../model/visit.dart';

class ClientsController extends ChangeNotifier {
  List<Client> clients = [
    Client(
      id: 1,
      clientNumber: "C12345",
      tradeName: "ABC Trading Co.",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdBy: "aaa",
      region: Region(id: 1, name: "California"),
      balance: 5000,
      commercialRegistration: "CR123456",
      professionLicensePath: "path/to/license.pdf",
      nationalId: "NID123456789",
      visits: [
        Visit(
          id: 1,
          visitDate: DateTime.now(),
          notes: "Initial visit",
        ),
      ],
    ),
    Client(
      id: 1,
      clientNumber: "C12345",
      tradeName: "ABC Trading Co.",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdBy: "aaa",
      region: Region(id: 1, name: "California"),
      balance: 5000,
      commercialRegistration: "CR123456",
      professionLicensePath: "path/to/license.pdf",
      nationalId: "NID123456789",
      visits: [
        Visit(
          id: 1,
          visitDate: DateTime.now(),
          notes: "Initial visit",
        ),
      ],
    ),
    Client(
      id: 1,
      clientNumber: "C12345",
      tradeName: "ABC Trading Co.",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdBy: 'aaa',
      region: Region(id: 1, name: "California"),
      balance: 5000,
      commercialRegistration: "CR123456",
      professionLicensePath: "path/to/license.pdf",
      nationalId: "NID123456789",
      visits: [
        Visit(
          id: 1,
          visitDate: DateTime.now(),
          notes: "Initial visit",
        ),
      ],
    ),
  ];


  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController clientPersonInChargeController =
  TextEditingController();
  final TextEditingController clientPhoneController = TextEditingController();
  final TextEditingController clientNotesController = TextEditingController();
  final TextEditingController clientStreetController = TextEditingController();
  final TextEditingController clientBuildingNumController =
  TextEditingController();
  final TextEditingController clientAdditionalInfoController =
  TextEditingController();
  String? clientSelectedType;
  String? clientSelectedRegion;



  static final _phoneRegExp = RegExp(r'^(079|077|078)[0-9]{7}$');


  void clearErrors() {
    errors.updateAll((key, value) => null);
    notifyListeners();
  }


  void setClientSelectedRegion(String? value, BuildContext context) {
    clientSelectedRegion = value;
    validateField(field: 'region', value: value, context: context);
    notifyListeners();
  }

  void setClientSelectedType(String? value, BuildContext context) {
    clientSelectedType = value;
    validateField(field: 'type', value: value, context: context);
    notifyListeners();
  }

  void _validatePhone(String? phoneNo, BuildContext context) {
    final newError = phoneNo == null || !_phoneRegExp.hasMatch(phoneNo)
        ? AppLocalizations.of(context)!.phone_error
        : null;
    if (errors['phone'] != newError) {
      errors['phone'] = newError;
    }
  }

  void _validateTradeName(String? name, BuildContext context) {
    final newError = (name == null || name.isEmpty)
        ? AppLocalizations.of(context)!.name_error
        : name.trim().split(' ').length < 2
        ? AppLocalizations.of(context)!.name_error_2
        : null;

    if (errors['tradeName'] != newError) {
      errors['tradeName'] = newError;
      notifyListeners();
    }
  }

  void _validatePersonInChargeName(String? name, BuildContext context) {
    final newError = (name == null || name.isEmpty)
        ? AppLocalizations.of(context)!.name_error
        : name.trim().split(' ').length < 2
        ? AppLocalizations.of(context)!.name_error_2
        : null;

    if (errors['personInCharge'] != newError) {
      errors['personInCharge'] = newError;
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
        ? AppLocalizations.of(context)!.type_error
        : null;

    if (errors['type'] != newError) {
      errors['type'] = newError;
      notifyListeners();
    }
  }

  void _validateStreet(String? street, BuildContext context) {
    final newError =
    street == null ? AppLocalizations.of(context)!.address_error : null;
    if (errors['street'] != newError) {
      errors['street'] = newError;
    }
  }

  void _validateBuildingNum(String? buildingNum, BuildContext context) {
    final newError =
    buildingNum == null ? AppLocalizations.of(context)!.address_error : null;
    if (errors['buildingNum'] != newError) {
      errors['buildingNum'] = newError;
    }
  }


  final Map<String, String?> errors = {
    'tradeName': null,
    'personInCharge':null,
    'phone': null,
    'street':null,
    'buildingNum':null,
    'region': null,
    'type': null,
  };

  void validateForm(
      {required BuildContext context,
        required String? tradeName,
        required String? personInCharge,
        required String? phone,
        required String? street,
        required int? buildingNum,
        required String? region,
        required String? type,
      }) {
    final oldErrors = Map<String, String?>.from(errors);

    _validateTradeName(tradeName, context);
    _validatePersonInChargeName(personInCharge, context);
    _validatePhone(phone, context);
    _validateType(type, context);
    _validateRegion(region, context);
    _validateStreet(street, context);
    _validateBuildingNum(buildingNum as String?, context);


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
      case 'tradeName':
        _validateTradeName(value, context);
        break;
      case 'personInCharge':
        _validatePersonInChargeName(value, context);
        break;
      case 'phone':
        _validatePhone(value, context);
        break;
      case 'street':
        _validateStreet(value, context);
        break;
      case 'buildingNum':
        _validateBuildingNum(value, context);
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

  void addNewClient(Client client) {
    clients.add(client);
    notifyListeners();
  }

  updateClient({
    required Client client,
    required int index,
  }) {
    clients[index] = client;
    notifyListeners();
  }


  void deleteUser(Client client) {
    if (clients.contains(client)) {
      clients.remove(client);
      notifyListeners();
    }
  }


  void clearClientFields() {
    clientNameController.clear();
    clientPersonInChargeController.clear();
    clientSelectedType = null;
    clientPhoneController.clear();
    clientSelectedRegion = null;
    clientStreetController.clear();
    clientNotesController.clear();
    clientBuildingNumController.clear();
  }

}