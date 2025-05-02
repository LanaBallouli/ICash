import 'package:flutter/cupertino.dart';
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
      orElse: () => Product(id: null, name: null, price: null),
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
    final unitPrice = selectedProduct?.price ?? 0;
    subTotal = (unitPrice * itemAmount) as double?;
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

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      final response = await supabase.from('products').select('id, name');

      if (response.isEmpty || !(response is List)) {
        throw Exception('Error fetching products');
      }

      products = List<Product>.from(
        (response as List)
            .map((clientJson) => Product.fromJson( clientJson)),
      );

      notifyListeners();
    } catch (e) {
      print('Failed to fetch products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  addItemsToInvoice({required Product product}) {
    invoiceProducts.add(product);
    notifyListeners();
  }
}
