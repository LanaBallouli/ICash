import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/product.dart';

class ProductController extends ChangeNotifier {
  String? selectedProduct;
  List<Product> products = [];
  List<Product> invoiceProducts = [];
  final supabase = Supabase.instance.client;
  bool isLoading = false;
  double? subTotal = 0;
  int itemAmount = 0;

  Product? get selectedProductDetails {
    if (selectedProduct == null) return null;
    return products.firstWhere(
          (product) => product.id.toString() == selectedProduct,
    );
  }

  void setSelectedProduct(String? productId) {
    selectedProduct = productId;
    itemAmount = 0; // Reset item amount
    subTotal = 0; // Reset subtotal
    calculateSubTotal(); // Recalculate subtotal (will be 0 initially)
    notifyListeners();
  }

  void calculateSubTotal() {
    final selectedProduct = selectedProductDetails;
    if (selectedProduct == null) {
      subTotal = 0;
    } else {
      subTotal = selectedProduct.price * itemAmount;
    }
    notifyListeners();
  }

  void incrementItemAmount() {
    itemAmount++;
    calculateSubTotal();
    notifyListeners();
  }

  void decrementItemAmount() {
    if (itemAmount > 0) {
      itemAmount--;
      calculateSubTotal();
      notifyListeners();
    }
  }

  void setItemAmount(int amount) {
    if (amount >= 0) {
      itemAmount = amount;
      notifyListeners();
    }
  }

  Future<void> fetchProducts(BuildContext context) async {
    try {
      isLoading = true;
      final response = await supabase.from('products').select('*');

      if (response.isEmpty) {
        throw Exception('Error fetching products');
      }

      products = (response as List)
          .map((item) => Product(
        id: item['id'],
        name: item['name'],
        description: item['description'],
        price: item['price']?.toDouble(),
        brand: item['brand'],
        quantity: item['quantity'],
        isAvailable: item['is_available'],
        imageUrl: item['image_url'],
        discount: item['discount']?.toDouble(),
        taxRate: item['tax_rate']?.toDouble(),
        createdAt: DateTime.parse(item['created_at']),
        updatedAt: DateTime.parse(item['updated_at']),
      ))
          .toList();

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch products: $e')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addItemsToInvoice({required Product product}) {
    final existingProduct = invoiceProducts.firstWhere(
          (p) => p.id == product.id,
    );

    print('Product already exists in the invoice.');
  
    notifyListeners();
  }

  void removeItemFromInvoice(Product product) {
    invoiceProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  void updateInvoiceItemQuantity(Product product, int newQuantity) {
    final existingProduct = invoiceProducts.firstWhere(
          (p) => p.id == product.id,
    );

    print('Updated quantity for product ${product.name}');
  
    notifyListeners();
  }
}