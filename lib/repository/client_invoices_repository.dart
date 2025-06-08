import '../model/client_invoices.dart';
import '../supabase_api.dart';

class ClientInvoiceRepository {
  final SupabaseApi _api;

  ClientInvoiceRepository(this._api);

  Future<void> assignInvoiceToClient(int clientId, int invoiceId) async {
    await _api.postData(
      table: 'client_invoices',
      body: ClientInvoice(
        clientId: clientId,
        invoiceId: invoiceId,
      ).toJson(),
      fromJsonT: (json) => ClientInvoice.fromJson(json),
    );
  }

  Future<List<ClientInvoice>> getAssignmentsByClientId(int clientId) async {
    final response = await _api.filterData<Map<String, dynamic>>(
      table: 'client_invoices',
      column: 'client_id',
      value: clientId,
      fromJsonT: (json) => json,
    );

    return response.map((e) => ClientInvoice.fromJson(e)).toList();
  }

  Future<List<ClientInvoice>> getAssignmentsByInvoiceId(int invoiceId) async {
    final response = await _api.filterData<Map<String, dynamic>>(
      table: 'client_invoices',
      column: 'invoice_id',
      value: invoiceId,
      fromJsonT: (json) => json,
    );

    return response.map((e) => ClientInvoice.fromJson(e)).toList();
  }
}