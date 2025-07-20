import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/repository/invoice_repository.dart';
import 'package:test_sales/model/invoice_item.dart';

class InvoicesController extends ChangeNotifier {
  final InvoiceRepository repository;
  List<Invoice> invoices = [];
  bool isLoading = false;
  String? errorMessage = "";
  int? lastFetchedSalesmanId;
  int? lastFetchedClientId;
  Client? selectedClient;
  int clientId = 1;
  List<InvoiceItem> selectedItems = [];

  TextEditingController invoiceNumberCtrl = TextEditingController();
  TextEditingController taxCtrl = TextEditingController(text: "0");
  TextEditingController discountCtrl = TextEditingController(text: "0");
  TextEditingController taxNumberController = TextEditingController();
  late DateTime issueDate = DateTime.now();
  late DateTime dueDate = DateTime.now().add(const Duration(days: 7));
  String type = "Cash";
  String notes = "";
  int taxNumber = 0;


  InvoicesController(this.repository);

  void setTaxNumber(int value) {
    taxNumber = value;
    notifyListeners();
  }

  void setSelectedClient(Client client) {
    selectedClient = client;
    notifyListeners();
  }

  void addSelectedItem(InvoiceItem item) {
    selectedItems.add(item);
    notifyListeners();
  }

  void removeSelectedItem(InvoiceItem item) {
    selectedItems.remove(item);
    notifyListeners();
  }

  double get subtotal => selectedItems.map((item) => item.total).sum;

  double get tax => double.tryParse(taxCtrl.text) ?? 0.0;

  double get discount => double.tryParse(discountCtrl.text) ?? 0.0;

  double get grandTotal => (subtotal + tax) - discount;

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
      _clearError();
    } catch (e) {
      _setError("Failed to load invoices for salesperson");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchInvoicesByClient(int clientId) async {
    if (lastFetchedClientId == clientId && invoices.isNotEmpty) {
      return;
    }

    _setLoading(true);
    try {
      final result = await repository.getInvoicesByClientId(clientId);
      invoices = result;
      lastFetchedClientId = clientId;
      _clearError();
    } catch (e) {
      _setError("Failed to load invoices for this client");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> createNewInvoice({required int userId}) async {
    if (clientId == -1 || selectedItems.isEmpty) {
      _setError("Please select a client and at least one product.");
      return;
    }

    _setLoading(true);

    try {
      final invoice = Invoice(
        id: null,
        invoiceNumber: invoiceNumberCtrl.text,
        type: type,
        clientId: clientId,
        issueDate: issueDate,
        dueDate: dueDate,
        tax: tax,
        taxNumber: "TAX-${invoiceNumberCtrl.text}",
        discount: discount,
        status: "Pending",
        creationTime: DateTime.now(),
        notes: notes,
        userId: userId,
        total: grandTotal,
      );

      final createdInvoice = await repository.createInvoice(invoice);

      // Save invoice items
      if (selectedItems.isNotEmpty) {
        for (var item in selectedItems) {
          final updatedItem = item.copyWith(invoiceId: createdInvoice.id!);
          await repository.addInvoiceItem(updatedItem);
        }
      }

      // Link invoice to client
      await repository.linkInvoiceToClient(createdInvoice.id!, clientId);

      resetFormFields();
      _clearError();
    } catch (e) {
      _setError("Failed to create invoice: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateExistingInvoice(Invoice invoice) async {
    _setLoading(true);

    try {
      final updated = invoice.copyWith(
        invoiceNumber: invoiceNumberCtrl.text,
        type: type,
        clientId: clientId,
        issueDate: issueDate,
        dueDate: dueDate,
        tax: tax,
        discount: discount,
        notes: notes,
        total: grandTotal,
      );

      final result = await repository.updateInvoice(updated);

      // Replace in list
      final index = invoices.indexWhere((i) => i.id == invoice.id);
      if (index != -1) {
        invoices[index] = result;
      }

      // Clear error and refresh state
      _clearError();
      resetFormFields();
    } catch (e) {
      _setError("Failed to update invoice: $e");
    } finally {
      _setLoading(false);
    }
  }

  void setIssueDate(DateTime date) {
    issueDate = date;
    dueDate = date.add(Duration(days: 7)); // Reset due date based on issue date
    notifyListeners();
  }

  void setDueDate(DateTime date) {
    dueDate = date;
    notifyListeners();
  }

  void setInvoiceType(String newType) {
    type = newType;
    notifyListeners();
  }

  void setTax(String value) {
    taxCtrl.text = value;
    notifyListeners();
  }

  void setDiscount(String value) {
    discountCtrl.text = value;
    notifyListeners();
  }

  void setNotes(String value) {
    notes = value;
    notifyListeners();
  }

  void resetFormFields() {
    invoiceNumberCtrl.clear();
    taxCtrl.text = "0";
    discountCtrl.text = "0";
    issueDate = DateTime.now();
    dueDate = DateTime.now().add(Duration(days: 7));
    type = "Cash";
    clientId = -1;
    notes = "";
    selectedItems.clear();
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

  bool hasLoadedForSalesman(int salesmanId) {
    return lastFetchedSalesmanId == salesmanId;
  }

  Future<void> fetchDebtInvoices() async {
    _setLoading(true);
    try {
      final debtInvoices = await repository.getDebtInvoices();
      invoices = debtInvoices;
      _clearError();
    } catch (e) {
      _setError("Failed to load debt invoices");
      print("Error fetching debt invoices: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  double getTotalDebtAmount() {
    return invoices
        .where((invoice) => invoice.type == "Debt")
        .map((invoice) => invoice.total)
        .fold<double>(0, (sum, total) => sum + total);
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