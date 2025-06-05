import 'package:test_sales/model/address.dart';
import '../supabase_api.dart';

class AddressRepository {
  final SupabaseApi _api;

  AddressRepository(this._api);

  /// Add a new address to Supabase
  Future<Address> save(Address address) async {
    final response = await _api.postData<Address>(
      table: 'addresses',
      body: address.toJson(),
      fromJsonT: (json) => Address.fromJson(json),
    );
    return response;
  }

  /// Get address by ID
  Future<Address> getById(int id) async {
    final response = await _api.getDataById<Address>(
      table: 'addresses',
      id: id,
      fromJsonT: (json) => Address.fromJson(json),
    );
    return response;
  }

  /// Update an existing address
  Future<Address> update(Address address) async {
    final response = await _api.updateData<Address>(
      table: 'addresses',
      id: address.id!,
      body: address.toJson(),
      fromJsonT: (json) => Address.fromJson(json),
    );
    return response;
  }

  /// Delete an address by ID
  Future<void> delete(int id) async {
    await _api.deleteData(table: 'addresses', id: id);
  }

  /// Get all addresses (optional)
  Future<List<Address>> getAll() async {
    final response = await _api.getDataList<Address>(
      table: 'addresses',
      fromJsonT: (json) => Address.fromJson(json),
    );
    return response;
  }
}