import 'package:test_sales/model/invoice.dart';
import '../supabase_api.dart';

class InvoiceRepository {
  final SupabaseApi _api;

  InvoiceRepository(this._api);

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