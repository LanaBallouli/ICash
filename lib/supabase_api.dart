import 'package:supabase/supabase.dart';

class SupabaseApi {
  final SupabaseClient _client;

  SupabaseApi(this._client);

  /// Generic method to fetch a list of items from any table
  Future<List<T>> getDataList<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJsonT,
    Map<String, Object?>? filter,
  }) async {
    var query = _client.from(table).select();

    if (filter != null) {
      filter.forEach((key, value) {
        query = query.eq(key, value!);
      });
    }

    final response = await query as List;

    return response.map((item) => fromJsonT(item)).toList();
  }

  /// Generic method to get a single item by ID
  Future<T> getDataById<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJsonT,
    required int id,
  }) async {
    final response = await _client
        .from(table)
        .select()
        .eq('id', id)
        .single();

    return fromJsonT(response);
  }

  /// Generic method to insert a new item into a table
  Future<T> postData<T>({
    required String table,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    final response = await _client
        .from(table)
        .insert(body)
        .select()
        .single();

    return fromJsonT(response);
  }

  /// Generic method to update an existing item
  Future<T> updateData<T>({
    required String table,
    required int id,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    final response = await _client
        .from(table)
        .update(body)
        .eq('id', id)
        .select()
        .single();

    return fromJsonT(response);
  }

  /// Generic method to delete an item by ID
  Future<void> deleteData({
    required String table,
    required int id,
  }) async {
    await _client.from(table).delete().eq('id', id);
  }

  /// Generic method to filter using `.eq()` or other operators
  Future<List<T>> filterData<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJsonT,
    required String column,
    required dynamic value,
  }) async {
    final response = await _client
        .from(table)
        .select()
        .eq(column, value) as List;

    return response.map((item) => fromJsonT(item)).toList();
  }

  /// Generic method to order results
  Future<List<T>> getDataListOrdered<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJsonT,
    required String orderByColumn,
    bool ascending = true,
  }) async {
    final response = await _client
        .from(table)
        .select()
        .order(orderByColumn, ascending: ascending) as List;

    return response.map((item) => fromJsonT(item)).toList();
  }

  /// Generic method to limit number of results
  Future<List<T>> getDataListWithLimit<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJsonT,
    int limit = 10,
  }) async {
    final response = await _client
        .from(table)
        .select()
        .limit(limit) as List;

    return response.map((item) => fromJsonT(item)).toList();
  }

  /// Generic method to search using `like`
  Future<List<T>> searchData<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJsonT,
    required String column,
    required String pattern,
  }) async {
    final response = await _client
        .from(table)
        .select()
        .like(column, pattern) as List;

    return response.map((item) => fromJsonT(item)).toList();
  }
}