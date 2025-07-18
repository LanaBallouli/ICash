import 'package:collection/collection.dart';
import 'package:test_sales/model/invoice.dart';
import '../model/invoice_item.dart';
import '../supabase_api.dart';

class InvoiceRepository {
  final SupabaseApi _api;

  InvoiceRepository(this._api);

  Future<InvoiceItem> addInvoiceItem(InvoiceItem item) async {
    final json = item.toJson();

    final response = await _api.postData<InvoiceItem>(
      table: 'invoice_items',
      body: json,
      fromJsonT: (data) => InvoiceItem.fromJson(data),
    );

    return response;
  }

  /// Fetch all invoices
  Future<List<Invoice>> getAllInvoices() async {
    return await _api.getDataList<Invoice>(
      table: 'invoices',
      fromJsonT: (json) => Invoice.fromJson(json),
    );
  }

  /// Fetch single invoice by ID
  Future<Invoice> getInvoiceById(int id) async {
    return await _api.getDataById<Invoice>(
      table: 'invoices',
      id: id,
      fromJsonT: (json) => Invoice.fromJson(json),
    );
  }

  /// Fetch invoices by client ID
  Future<List<Invoice>> getInvoicesByClientId(int clientId) async {
    return await _api.filterData<Invoice>(
      table: 'invoices',
      column: 'client_id',
      value: clientId,
      fromJsonT: (json) => Invoice.fromJson(json),
    );

  }/// Fetch all Debt invoices
  Future<List<Invoice>> getDebtInvoices() async {
    return await _api.filterData<Invoice>(
      table: 'invoices',
      column: 'type',
      value: 'Debt',
      fromJsonT: (json) => Invoice.fromJson(json),
    );
  }

  /// Fetch total amount of all Debt invoices
  Future<double> getTotalDebtInvoices() async {
    final response = await _api.filterData<Invoice>(
      table: 'invoices',
      column: 'type',
      value: 'Debt',
      fromJsonT: (json) => Invoice.fromJson(json),
    );

    return response.map((invoice) => invoice.total).sum;
  }


  /// Add multiple invoice items at once
  Future<List<InvoiceItem>> addInvoiceItems({required List<InvoiceItem> items}) async {
    final List<dynamic> jsonList = items.map((item) => item.toJson()).toList();

    final response = await _api.bulkInsertData(
      table: 'invoice_items',
      bodyList: jsonList,
      fromJsonT: (data) => InvoiceItem.fromJson(data),
    );

    return response.map((json) => InvoiceItem.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<List<InvoiceItem>> getInvoiceItems(int invoiceId) async {
    final result = await _api.filterData<InvoiceItem>(
      table: 'invoice_items',
      column: 'invoice_id',
      value: invoiceId,
      fromJsonT: (json) => InvoiceItem.fromJson(json),
    );

    return result;
  }
  /// Link invoice to client in client_invoices table
  Future<void> linkInvoiceToClient(int invoiceId, int clientId) async {
    final body = {
      'invoice_id': invoiceId,
      'client_id': clientId,
      'assigned_at': DateTime.now().toIso8601String(),
    };

    await _api.postData<Map<String, dynamic>>(
      table: 'client_invoices',
      body: body,
      fromJsonT: (data) => data,
    );
  }


  /// Fetch invoices by salesman ID
  Future<List<Invoice>> getInvoicesBySalesmanId(int userId) async {
    return await _api.filterData<Invoice>(
      table: 'invoices',
      column: 'user_id',
      value: userId,
      fromJsonT: (json) => Invoice.fromJson(json),
    );
  }

  /// Add new invoice
  Future<Invoice> createInvoice(Invoice invoice) async {
    return await _api.postData<Invoice>(
      table: 'invoices',
      body: invoice.toJson(),
      fromJsonT: (json) => Invoice.fromJson(json),
    );
  }

  /// Update existing invoice
  Future<Invoice> updateInvoice(Invoice invoice) async {
    return await _api.updateData<Invoice>(
      table: 'invoices',
      id: invoice.id!,
      body: invoice.toJson(),
      fromJsonT: (json) => Invoice.fromJson(json),
    );
  }

  /// Delete invoice by ID
  Future<void> deleteInvoice(int id) async {
    return await _api.deleteData(table: 'invoices', id: id);
  }
}