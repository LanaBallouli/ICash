import 'package:flutter/cupertino.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/repository/invoice_repository.dart';

class InvoicesController extends ChangeNotifier {
  final InvoiceRepository repository;
  List<Invoice> invoices = [];
  bool isLoading = false;
  String? errorMessage = "";
  int? lastFetchedSalesmanId;
  int? lastFetchedClientId;

  InvoicesController(this.repository);

  Future<void> fetchAllInvoices() async {
    _setLoading(true);
    try {
      invoices = await repository.getAllInvoices();
      _clearError();
    } catch (e) {
      _setError("Failed to fetch invoices");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchInvoiceById(int id) async {
    _setLoading(true);
    try {
      final invoice = await repository.getInvoiceById(id);
      final index = invoices.indexWhere((i) => i.id == id);
      if (index != -1) {
        invoices[index] = invoice;
      } else {
        invoices.add(invoice);
      }
      _clearError();
    } catch (e) {
      _setError("Failed to load invoice");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchInvoicesBySalesman(int salesmanId) async {
    if (lastFetchedSalesmanId == salesmanId && invoices.isNotEmpty) {
      return;
    }

    _setLoading(true);
    try {
      invoices = await repository.getInvoicesBySalesmanId(salesmanId);
      lastFetchedSalesmanId = salesmanId;
    } catch (e) {
      _setError("Failed to load invoices");
      print("Error fetching invoices by salesman: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchInvoicesByClient(int clientId) async {
    if (lastFetchedClientId == clientId && invoices.isEmpty) return;

    _setLoading(true);
    try {
      final List<Invoice> result = await repository.getInvoicesByClientId(clientId);
      invoices = result;
      lastFetchedClientId = clientId;
      _clearError();
    } catch (e) {
      _setError("Failed to load invoices for this client");
      print("Error fetching invoices by client: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  bool hasLoadedForSalesman(int salesmanId) {
    return lastFetchedSalesmanId == salesmanId;
  }


  Future<void> addNewInvoice(Invoice invoice) async {
    _setLoading(true);
    try {
      final added = await repository.createInvoice(invoice);
      invoices.add(added);
      _clearError();
    } catch (e) {
      _setError("Failed to add invoice");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> updateInvoice(Invoice invoice) async {
    _setLoading(true);
    try {
      final updated = await repository.updateInvoice(invoice);
      final index = invoices.indexWhere((i) => i.id == invoice.id);
      if (index != -1) {
        invoices[index] = updated;
      }
      _clearError();
    } catch (e) {
      _setError("Failed to update invoice");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> deleteInvoice(int id) async {
    _setLoading(true);
    try {
      await repository.deleteInvoice(id);
      invoices.removeWhere((i) => i.id == id);
      _clearError();
    } catch (e) {
      _setError("Failed to delete invoice");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    errorMessage = null;
    notifyListeners();
  }

  double getTotalSalesForSalesman(int userId) {
    return invoices
        .where((i) => i.userId == userId)
        .map((i) => i.total)
        .toList()
        .fold<double>(0, (sum, amount) => sum + amount);
  }

  double getTotalSalesForClient(int clientId) {
    return invoices
        .where((i) => i.clientId == clientId)
        .map((i) => i.total)
        .toList()
        .fold<double>(0, (sum, amount) => sum + amount);
  }
}