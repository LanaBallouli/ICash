import '../model/salesman.dart';
import '../supabase_api.dart';

class SalesmanRepository {
  final SupabaseApi _api;

  SalesmanRepository(this._api);

  Future<List<SalesMan>> getAllSalesmen() async {
    return await _api.getDataList<SalesMan>(
      table: 'salesmen',
      fromJsonT: (json) => SalesMan.fromJson(json),
    );
  }

  Future<SalesMan> getSalesmanById(int id) async {
    return await _api.getDataById<SalesMan>(
      table: 'salesmen',
      id: id,
      fromJsonT: (json) => SalesMan.fromJson(json),
    );
  }

  Future<List<SalesMan>> getSalesmenByRegion(int regionId) async {
    final result = await _api.filterData<SalesMan>(
      table: 'salesmen',
      column: 'region_id',
      value: regionId,
      fromJsonT: (json) => SalesMan.fromJson(json),
    );
    return result;
  }

  Future<List<SalesMan>> getSalesmenByClientId(int clientId) async {
    final response = await _api.getDataList<Map<String, dynamic>>(
      table: 'client_salesman',
      fromJsonT: (json) => json,
      filter: {'client_id': clientId},
    );

    final salesmanIds = response.map((item) => item['salesman_id'] as int).toList();

    if (salesmanIds.isEmpty) return [];

    final salesmen = await _api.filterData<SalesMan>(
      table: 'salesmen',
      column: 'id',
      value: 'in.(${salesmanIds.join(",")})',
      fromJsonT: (json) => SalesMan.fromJson(json),
    );

    return salesmen;
  }

  Future<SalesMan> createSalesman(SalesMan salesman) async {
    return await _api.postData<SalesMan>(
      table: 'salesmen',
      body: salesman.toJson(),
      fromJsonT: (json) => SalesMan.fromJson(json),
    );
  }

  Future<SalesMan> updateSalesman(SalesMan salesman) async {
    return await _api.updateData<SalesMan>(
      table: 'salesmen',
      id: salesman.id!,
      body: salesman.toJson(),
      fromJsonT: (json) => SalesMan.fromJson(json),
    );
  }

  Future<void> deleteSalesman(int id) async {
    return await _api.deleteData(table: 'salesmen', id: id);
  }


}