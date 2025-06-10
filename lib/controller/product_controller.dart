import 'package:flutter/cupertino.dart';
import 'package:test_sales/repository/product_repository.dart';
import 'package:test_sales/model/product.dart';

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