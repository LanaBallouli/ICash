import 'package:flutter/cupertino.dart';
import 'package:test_sales/model/visit.dart';
import 'package:test_sales/repository/visit_repository.dart';

class VisitsController extends ChangeNotifier {
  final VisitRepository repository;
  List<Visit> visits = [];
  bool isLoading = false;

  VisitsController(this.repository);


  Future<void> fetchAllVisits() async {
    _setLoading(true);
    try {
      visits = await repository.getAllVisits();
    } catch (e) {
      _handleError(e, "fetching visits");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchVisitsByClient(int clientId) async {
    _setLoading(true);
    try {
      visits = await repository.getVisitsByClientId(clientId);
    } catch (e) {
      _handleError(e, "fetching visits by client");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }


  Future<void> fetchVisitsBySalesman(int salesmanId) async {
    _setLoading(true);
    try {
      visits = await repository.getVisitsBySalesmanId(salesmanId);
      notifyListeners();
    } catch (e) {
      _handleError(e, "fetching visits by salesman");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addNewVisit(Visit visit) async {
    _setLoading(true);
    try {
      final added = await repository.createVisit(visit);
      visits.add(added);
    } catch (e) {
      _handleError(e, "adding visit");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> updateVisit(Visit visit) async {
    _setLoading(true);
    try {
      final updated = await repository.updateVisit(visit);
      final index = visits.indexWhere((v) => v.id == visit.id);
      if (index != -1) {
        visits[index] = updated;
      }
    } catch (e) {
      _handleError(e, "updating visit");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> deleteVisit(int id) async {
    _setLoading(true);
    try {
      await repository.deleteVisit(id);
      visits.removeWhere((v) => v.id == id);
    } catch (e) {
      _handleError(e, "deleting visit");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _handleError(dynamic error, String operation) {
    print("Error $operation: $error");
  }
}