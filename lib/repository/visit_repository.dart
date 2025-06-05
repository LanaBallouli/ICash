import 'package:test_sales/model/visit.dart';
import '../supabase_api.dart';

class VisitRepository {
  final SupabaseApi _api;

  VisitRepository(this._api);

  /// Fetch all visits
  Future<List<Visit>> getAllVisits() async {
    final result = await _api.getDataList<Visit>(
      table: 'visits',
      fromJsonT: (json) => Visit.fromJson(json),
    );
    return result;
  }

  /// Fetch visit by ID
  Future<Visit> getVisitById(int id) async {
    return await _api.getDataById<Visit>(
      table: 'visits',
      id: id,
      fromJsonT: (json) => Visit.fromJson(json),
    );
  }

  /// Fetch visits by client ID
  Future<List<Visit>> getVisitsByClientId(int clientId) async {
    final result = await _api.filterData<Visit>(
      table: 'visits',
      column: 'client_id',
      value: clientId,
      fromJsonT: (json) => Visit.fromJson(json),
    );
    return result;
  }

  /// Fetch visits by salesman ID
  Future<List<Visit>> getVisitsBySalesmanId(int userId) async {
    final result = await _api.filterData<Visit>(
      table: 'visits',
      column: 'user_id',
      value: userId,
      fromJsonT: (json) => Visit.fromJson(json),
    );
    return result;
  }

  /// Add new visit
  Future<Visit> createVisit(Visit visit) async {
    return await _api.postData<Visit>(
      table: 'visits',
      body: visit.toJson(),
      fromJsonT: (json) => Visit.fromJson(json),
    );
  }

  /// Update existing visit
  Future<Visit> updateVisit(Visit visit) async {
    return await _api.updateData<Visit>(
      table: 'visits',
      id: visit.id!,
      body: visit.toJson(),
      fromJsonT: (json) => Visit.fromJson(json),
    );
  }

  /// Delete visit by ID
  Future<void> deleteVisit(int id) async {
    return await _api.deleteData(table: 'visits', id: id);
  }
}