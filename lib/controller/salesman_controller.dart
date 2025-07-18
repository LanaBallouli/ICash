import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../model/salesman.dart';
import '../repository/salesman_repository.dart';

class SalesmanController extends ChangeNotifier {
  final SalesmanRepository repository;
  final List<SalesMan> fav = [];
  List<SalesMan> salesMen = [];
  bool isLoading = false;
  List<SalesMan> assignedSalesmen = [];
  String errorMessage = "";
  bool hasLoadedOnce = false;
  int? lastFetchedRegionId;
  SalesMan? currentSalesman;

  SalesmanController(this.repository);

  Future<SalesMan?> getSalesmanBySupabaseUid(String supabaseUid) async {
    return await repository.getSalesmanBySupabaseUid(supabaseUid);
  }

  Future<void> fetchCurrentSalesman(BuildContext context) async {
    final local = AppLocalizations.of(context)!;

    try {
      final supabaseUser = Supabase.instance.client.auth.currentUser;
      if (supabaseUser == null) {
        throw Exception(local.user_not_found);
      }

      currentSalesman = await repository.getUserBySupabaseUid(supabaseUser.id);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }




  Future<void> fetchSalesmen() async {
    if (isLoading || hasLoadedOnce) return;

    _setLoading(true);
    try {
      salesMen = await repository.getAllSalesmen();
      hasLoadedOnce = true;
    } catch (e) {
      _setError("Failed to load salesmen");
      print("Error fetching salesmen: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchSalesmenByRegion(int regionId) async {
    if (isLoading && lastFetchedRegionId == regionId) return;

    _setLoading(true);
    try {
      salesMen = await repository.getSalesmenByRegion(regionId);
      lastFetchedRegionId = regionId;
      hasLoadedOnce = true;
    } catch (e) {
      _setError("Failed to load salesmen for this region");
      print("Error fetching salesmen by region: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addNewSalesman(SalesMan salesman) async {
    _setLoading(true);
    try {
      final added = await repository.createSalesman(salesman);
      salesMen.add(added);
      notifyListeners();
    } catch (e) {
      _setError("Failed to add new salesman");
      print("Error adding salesman: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateSalesman(SalesMan salesman, int index) async {
    _setLoading(true);
    try {
      final updated = await repository.updateSalesman(salesman);
      salesMen[index] = updated;
      notifyListeners();
    } catch (e) {
      _setError("Failed to update salesman");
      print("Error updating salesman: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteSalesman(int id) async {
    _setLoading(true);
    try {
      await repository.deleteSalesman(id);
      salesMen.removeWhere((salesman) => salesman.id == id);
      notifyListeners();
    } catch (e) {
      _setError("Failed to delete salesman");
      print("Error deleting salesman: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<List<SalesMan>> getAssignedSalesmen(int clientId) async {
    try {
      final salesmen = await repository.getSalesmenByClientId(clientId);
      notifyListeners();
      return salesmen;
    } catch (e) {
      _setError("Failed to load assigned salesmen");
      print("Error fetching assigned salesmen: $e");
      return [];
    }
  }

  String getRegionName(int regionId, BuildContext context) {
    final regions = AppConstants.getRegions(context);
    final region = regions.firstWhereOrNull((r) => r.id == regionId);
    return region?.name ?? "Unknown";
  }


  void toggleFavourite(SalesMan salesman) {
    if (fav.contains(salesman)) {
      fav.remove(salesman);
    } else {
      fav.add(salesman);
    }
    notifyListeners();
  }

  bool isFavourite(SalesMan salesman) => fav.contains(salesman);

  // --- Private Helpers ---

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }
}