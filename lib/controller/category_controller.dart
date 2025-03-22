import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/product_category.dart';

class CategoryController extends ChangeNotifier {
  String? selectedCategory;
  List<ProductCategory> category = [];
  final supabase = Supabase.instance.client;
  bool isLoading = false;

  Future<void> fetchCategory() async {
    try {
      isLoading= true;
      final response = await supabase.from('product_categories').select('id, name');

      if (response.isEmpty || !(response is List)) {
        throw Exception('Error fetching category');
      }

      category = List<ProductCategory>.from(
        (response as List)
            .map((clientJson) => ProductCategory.fromJson(json: clientJson)),
      );

      notifyListeners();
    } catch (e) {
      print('Failed to fetch category: $e');
    } finally {
      isLoading = false;
    }
  }
}