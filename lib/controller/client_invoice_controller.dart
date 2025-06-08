import 'package:flutter/cupertino.dart';
import '../model/client_invoices.dart';
import '../repository/client_invoices_repository.dart';

class ClientInvoiceController extends ChangeNotifier {
  final ClientInvoiceRepository repository;
  List<ClientInvoice> assignments = [];
  bool isLoading = false;
  String errorMessage = "";

  ClientInvoiceController(this.repository);

  Future<void> fetchAssignmentsByClientId(int clientId) async {
    _setLoading(true);
    try {
      assignments = await repository.getAssignmentsByClientId(clientId);
    } catch (e) {
      _setError("Failed to load client invoices");
      print("Error fetching client invoices: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addAssignment(int clientId, int invoiceId) async {
    try {
      await repository.assignInvoiceToClient(clientId, invoiceId);
      assignments.add(ClientInvoice(clientId: clientId, invoiceId: invoiceId));
      notifyListeners();
    } catch (e) {
      _setError("Failed to assign invoice");
      print("Error assigning invoice: $e");
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearErrors() {
    errorMessage = "";
    notifyListeners();
  }
}