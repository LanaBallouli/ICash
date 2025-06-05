import 'package:test_sales/model/client.dart';

import '../supabase_api.dart';

class ClientRepository {
  final SupabaseApi _api;

  ClientRepository(this._api);

  /// Fetch all clients
  Future<List<Client>> getAllClients() async {
    final result = await _api.getDataList<Client>(
      table: 'clients',
      fromJsonT: (json) => Client.fromJson(json),
    );
    return result;
  }

  /// Fetch client by ID
  Future<Client> getClientById(int id) async {
    final result = await _api.getDataById<Client>(
      table: 'clients',
      id: id,
      fromJsonT: (json) => Client.fromJson(json),
    );
    return result;
  }

  Future<List<Client>> getClientsBySalesman(int salesmanId) async {
    final response = await _api.getDataList<Map<String, dynamic>>(
      table: 'client_salesman',
      fromJsonT: (json) => json,
      filter: {'salesman_id': salesmanId},
    );

    final clientIds = response.map((item) => item['client_id'] as int).toList();

    if (clientIds.isEmpty) return [];

    final clients = await _api.filterData<Client>(
      table: 'clients',
      column: 'id',
      value: 'in.(${clientIds.join(",")})',
      fromJsonT: (json) => Client.fromJson(json),
    );

    return clients;
  }

  /// Add new client
  Future<Client> createClient(Client client) async {
    final result = await _api.postData<Client>(
      table: 'clients',
      body: client.toJson(),
      fromJsonT: (json) => Client.fromJson(json),
    );
    return result;
  }

  /// Update existing client
  Future<Client> updateClient(Client client) async {
    final result = await _api.updateData<Client>(
      table: 'clients',
      id: client.id!,
      body: client.toJson(),
      fromJsonT: (json) => Client.fromJson(json),
    );
    return result;
  }

  /// Delete client by ID
  Future<void> deleteClient(int id) async {
    await _api.deleteData(table: 'clients', id: id);
  }

  /// Get clients by region
  Future<List<Client>> getClientsByRegion(int regionId) async {
    final result = await _api.filterData<Client>(
      table: 'clients',
      column: 'region_id',
      value: regionId,
      fromJsonT: (json) => Client.fromJson(json),
    );
    return result;
  }

  /// Search clients by name or trade name
  Future<List<Client>> searchClients(String pattern) async {
    final result = await _api.searchData<Client>(
      table: 'clients',
      column: 'trade_name',
      pattern: '%$pattern%',
      fromJsonT: (json) => Client.fromJson(json),
    );
    return result;
  }
}