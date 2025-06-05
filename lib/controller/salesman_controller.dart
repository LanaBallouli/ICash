import 'package:flutter/cupertino.dart';
import '../model/salesman.dart';
import '../repository/salesman_repository.dart';

class SalesmanController extends ChangeNotifier {
  final SalesmanRepository repository;
  final List<SalesMan> fav = [];
  List<SalesMan> salesMen = [];
  bool isLoading = false;
  List<SalesMan> assignedSalesmen = [];

  SalesmanController(this.repository);


  Future<void> fetchSalesmen() async {
    _setLoading(true);
    try {
      salesMen = await repository.getAllSalesmen();
      notifyListeners();
    } catch (e) {
      _handleError(e, "fetching salesmen");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchSalesmenByRegion(int regionId) async {
    _setLoading(true);
    try {
      salesMen = await repository.getSalesmenByRegion(regionId);
      notifyListeners();
    } catch (e) {
      _handleError(e, "fetching salesmen by region");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addNewSalesman(SalesMan salesman) async {
    _setLoading(true);
    try {
      final added = await repository.createSalesman(salesman);
      salesMen.add(added);
      notifyListeners();
    } catch (e) {
      _handleError(e, "adding new salesman");
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
      _handleError(e, "updating salesman");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteSalesman(SalesMan salesman) async {
    _setLoading(true);
    try {
      await repository.deleteSalesman(salesman.id!);
      salesMen.removeWhere((s) => s.id == salesman.id);
      notifyListeners();
    } catch (e) {
      _handleError(e, "deleting salesman");
    } finally {
      _setLoading(false);
    }
  }

  Future<List<SalesMan>> getAssignedSalesmen(int clientId) async {
    _setLoading(true);

    try {
      final salesmen = await repository.getSalesmenByClientId(clientId);
      assignedSalesmen = salesmen;
      notifyListeners();
      return salesmen;
    } catch (e) {
      _handleError(e, "loading salesmen for client");
      return [];
    } finally {
      _setLoading(false);
    }
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

  void _handleError(dynamic error, String operation) {
    print("Error $operation: $error");
  }
}