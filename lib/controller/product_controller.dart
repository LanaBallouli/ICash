import 'package:flutter/cupertino.dart';
import 'package:test_sales/repository/product_repository.dart';
import 'package:test_sales/model/product.dart';

import '../l10n/app_localizations.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository repository;
  List<Product> products = [];
  bool isLoading = false;
  String errorMessage = "";
  int? lastFetchedCategoryId;
  bool hasLoadedOnce = false;

  ProductController(this.repository);

  Future<void> fetchAllProducts() async {
    if (isLoading || hasLoadedOnce) return;

    _setLoading(true);
    try {
      products = await repository.getAllProducts();
      hasLoadedOnce = true;
    } catch (e) {
      _setError("Failed to load products");
      print("Error fetching products: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchProductById(int id) async {
    _setLoading(true);
    try {
      final product = await repository.getProductById(id);
      final index = products.indexWhere((p) => p.id == id);
      if (index != -1) {
        products[index] = product;
      } else {
        products.add(product);
      }
    } catch (e) {
      _setError("Failed to load product details");
      print("Error fetching product by ID: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addNewProduct(Product product) async {
    _setLoading(true);
    try {
      final added = await repository.createProduct(product);
      products.add(added);
    } catch (e) {
      _setError("Failed to add product");
      print("Error adding product: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    _setLoading(true);
    try {
      final updated = await repository.updateProduct(product);
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = updated;
      }
    } catch (e) {
      _setError("Failed to update product");
      print("Error updating product: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    _setLoading(true);
    try {
      await repository.deleteProduct(id);
      products.removeWhere((p) => p.id == id);
    } catch (e) {
      _setError("Failed to delete product");
      print("Error deleting product: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // --- Helpers ---

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearErrors() {
    errorMessage = "";
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    brandController.clear();
    quantityController.clear();
    discountController.clear();
    taxRateController.clear();
    isAvailable = true;
    errors.clear();
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController taxRateController = TextEditingController();

  bool isAvailable = true;

  toggleAvailableProduct (){
    isAvailable = !isAvailable;
    notifyListeners();
  }

  Map<String, String?> errors = {
    'name': null,
    'description': null,
    'price': null,
    'brand': null,
    'quantity': null,
    'discount': null,
    'tax_rate': null
  };

  bool _mapsEqual(Map<String, String?> a, Map<String, String?> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  bool isFormValid() => errors.isEmpty;

  void validateForm({required BuildContext context}) {
    final local = AppLocalizations.of(context)!;
    final oldErrors = Map<String, String?>.from(errors);

    validateName(local);
    validateDescription(local);
    validatePrice(local);
    validateBrand(local);
    validateQuantity(local);
    validateDiscount(local);
    validateTaxRate(local);

    notifyListeners();

    if (!_mapsEqual(oldErrors, errors)) {
      notifyListeners();
    }
  }

  void validateName(AppLocalizations local) {
    if (nameController.text.trim().isEmpty) {
      errors['name'] = local.field_cant_be_empty;
    } else {
      errors.remove('name');
    }
    notifyListeners();
  }

  void validateDescription(AppLocalizations local) {
    if (descriptionController.text.trim().isEmpty) {
      errors['description'] = local.field_cant_be_empty;
    } else {
      errors.remove('description');
    }
    notifyListeners();
  }

  void validatePrice(AppLocalizations local) {
    final value = double.tryParse(priceController.text);
    if (value == null || value <= 0) {
      errors['price'] = local.must_be_greater_than_zero;
    } else {
      errors.remove('price');
    }
    notifyListeners();
  }

  void validateBrand(AppLocalizations local) {
    if (brandController.text.trim().isEmpty) {
      errors['brand'] = local.field_cant_be_empty;
    } else {
      errors.remove('brand');
    }
    notifyListeners();
  }

  void validateQuantity(AppLocalizations local) {
    final value = int.tryParse(quantityController.text);
    if (value == null || value <= 0) {
      errors['quantity'] = local.must_be_greater_than_zero;
    } else {
      errors.remove('quantity');
    }
    notifyListeners();
  }

  void validateDiscount(AppLocalizations local) {
    final value = double.tryParse(discountController.text);
    if (value == null || value < 0) {
      errors['discount'] = local.must_be_valid_percentage;
    } else if (value > 100) {
      errors['discount'] = local.discount_cannot_exceed_100;
    } else {
      errors.remove('discount');
    }
    notifyListeners();
  }

  void validateTaxRate(AppLocalizations local) {
    final value = double.tryParse(taxRateController.text);
    if (value == null || value < 0) {
      errors['tax_rate'] = local.must_be_valid_percentage;
    } else if (value > 100) {
      errors['tax_rate'] = local.tax_rate_cannot_exceed_100;
    } else {
      errors.remove('tax_rate');
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    brandController.dispose();
    quantityController.dispose();
    discountController.dispose();
    taxRateController.dispose();
    super.dispose();
  }
}
