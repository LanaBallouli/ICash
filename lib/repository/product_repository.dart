import '../model/product.dart';
import '../supabase_api.dart';

class ProductRepository {
  final SupabaseApi _api;

  ProductRepository(this._api);

  Future<List<Product>> getAllProducts() async {
    final response = await _api.getDataList<Map<String, dynamic>>(
      table: 'products',
      fromJsonT: (json) => json,
    );

    return response.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> getProductById(int id) async {
    return _api.getDataById<Product>(
      table: 'products',
      id: id,
      fromJsonT: (json) => Product.fromJson(json),
    );
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await _api.filterData<Map<String, dynamic>>(
      table: 'products',
      column: 'category',
      value: category,
      fromJsonT: (json) => json,
    );

    return response.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> createProduct(Product product) async {
    final body = product.toJson()
      ..removeWhere((key, value) => key == 'id' || key == 'created_at');

    final response = await _api.postData(
      table: 'products',
      body: body,
      fromJsonT: (json) => Product.fromJson(json),
    );

    return response;
  }

  Future<Product> updateProduct(Product product) async {
    final body = product.toJson()
      ..removeWhere((key, value) => key == 'created_at');

    final response = await _api.updateData(
      table: 'products',
      id: product.id!,
      body: body,
      fromJsonT: (json) => Product.fromJson(json),
    );

    return response;
  }

  Future<void> deleteProduct(int id) async {
    await _api.deleteData(table: 'products', id: id);
  }
}