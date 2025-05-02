import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sales/model/client.dart';

class ClientsController extends ChangeNotifier {
  late Database database;
  String? selectedClient;

  // List<CashClient> cashClients = [];
  // List<DebtClient> debtClients = [];
  final supabase = Supabase.instance.client;
  bool isLoading = false;

  // Future<void> addNewCashClient(CashClient newClient) async {
  //   try {
  //     isLoading = true;
  //     // Convert the client object to JSON
  //     final jsonData = newClient.toJson();
  //
  //     final response = await supabase.from('clients_cash').insert(jsonData);
  //
  //     if (response is Map<String, dynamic> && response.containsKey('error')) {
  //       throw Exception(response['error']);
  //     }
  //
  //     // Optionally, fetch the newly inserted client to ensure consistency
  //     final fetchedClient = await supabase
  //         .from('clients_cash')
  //         .select('*')
  //         .eq(
  //             'trade_name',
  //             newClient
  //                 .tradeName!) // Match by trade name or another unique field
  //         .single();
  //
  //     // Add the fetched client to the list
  //     cashClients.add(CashClient.fromJson(json: fetchedClient));
  //     notifyListeners();
  //
  //     print('New client cash added successfully: ${fetchedClient}');
  //   } catch (e) {
  //     print('Error adding new client cash: $e');
  //     rethrow; // Propagate the error to the caller
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> addNewDebtClient(DebtClient newClient) async {
  //   try {
  //     isLoading = true;
  //     // Convert the client object to JSON
  //     final jsonData = newClient.toJson();
  //
  //     final response = await supabase.from('clients_debt').insert(jsonData);
  //
  //     if (response is Map<String, dynamic> && response.containsKey('error')) {
  //       throw Exception(response['error']);
  //     }
  //
  //     // Optionally, fetch the newly inserted client to ensure consistency
  //     final fetchedClient = await supabase
  //         .from('clients_debt')
  //         .select('*')
  //         .eq(
  //             'trade_name',
  //             newClient
  //                 .tradeName!) // Match by trade name or another unique field
  //         .single();
  //
  //     // Add the fetched client to the list
  //     debtClients.add(DebtClient.fromJson(json: fetchedClient));
  //     notifyListeners();
  //
  //     print('New client debt added successfully: ${fetchedClient}');
  //   } catch (e) {
  //     print('Error adding new client debt: $e');
  //     rethrow; // Propagate the error to the caller
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> fetchCashClients() async {
  //   try {
  //     isLoading = true;
  //     // Fetch data from the 'clients_cash' table
  //     final response = await supabase
  //         .from('clients_cash')
  //         .select('id, trade_name'); // Select only necessary fields
  //
  //     // Check if the response is a list
  //     if (response == null || !(response is List)) {
  //       throw Exception('Error fetching clients cash');
  //     }
  //
  //     // Map the response data to a List<Client>
  //     cashClients = List<CashClient>.from(
  //       (response as List)
  //           .map((clientJson) => CashClient.fromJson(json: clientJson)),
  //     );
  //
  //     notifyListeners(); // Notify listeners about the change in the clients list
  //   } catch (e) {
  //     print('Failed to fetch clients cash: $e');
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> fetchDebtClients() async {
  //   try {
  //     isLoading = true;
  //
  //     // Fetch data from the 'clients_cash' table
  //     final response = await supabase
  //         .from('clients_debt')
  //         .select('id, trade_name'); // Select only necessary fields
  //
  //     // Check if the response is a list
  //     if (response == null || !(response is List)) {
  //       throw Exception('Error fetching clients debt');
  //     }
  //
  //     // Map the response data to a List<Client>
  //     debtClients = List<DebtClient>.from(
  //       (response as List)
  //           .map((clientJson) => DebtClient.fromJson(json: clientJson)),
  //     );
  //
  //     notifyListeners(); // Notify listeners about the change in the clients list
  //   } catch (e) {
  //     print('Failed to fetch clients debt: $e');
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  void setSelectedClient(String? client) {
    selectedClient = client;
    notifyListeners();
  }

// Future<void> fetchClientsBasedOnInvoiceType(String? invoiceType) async {
//   try {
//     isLoading = true;
//     if (invoiceType == 'cash_invoice') {
//       await fetchCashClients();
//     } else if (invoiceType == 'dept_invoice') {
//       await fetchDebtClients();
//     }
//   } finally {
//     isLoading = false;
//     notifyListeners();
//   }
// }}

}