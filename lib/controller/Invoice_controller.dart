import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'clients_controller.dart';

class InvoiceController extends ChangeNotifier {
  String? invoiceType;
  late ClientsController clientsController;
  final supabase = Supabase.instance.client;
  bool isLoading = false;
  int? nextInvoiceNumber;
  bool isCashInvoice = true;
  double? subtotal;
  Color? cashColor = Color(0xFF170F4C);
  Color? cashTextColor = Colors.white;
  Color? debtColor = Colors.white;
  Color? debtTextColor = Color(0xFF170F4C);
  int? amount = 1;
  bool? increment = true;


  TextEditingController taxTextEditingController = TextEditingController();
  TextEditingController discountTextEditingController = TextEditingController();

  @override
  void dispose() {
    taxTextEditingController.dispose();
    discountTextEditingController.dispose();
    super.dispose();
  }

  InvoiceController({required this.clientsController});

  void setCashInvoice(bool isCash) {
    isCashInvoice = isCash;
    notifyListeners();
  }

  void updateProductAmount(bool increment){
    if(increment){
      amount = amount! + 1;
    } else if (amount! > 0){
      amount = amount! - 1;
    }
    notifyListeners();
  }

  void setProductAmount(int proAmount) {
    if (proAmount >= 0) {
      amount = proAmount; // Directly set the amount (with validation)
      notifyListeners();
    } else {
      throw ArgumentError("Amount cannot be negative");
    }
  }


  void setInvoiceTypeColor(bool isCash) {
    cashColor = isCash ? Color(0xFF170F4C) : Colors.white;
    cashTextColor = isCash ? Colors.white : Color(0xFF170F4C);
    debtColor = !isCash ? Color(0xFF170F4C) : Colors.white;
    debtTextColor = !isCash ? Colors.white: Color(0xFF170F4C);
    notifyListeners();
  }

  String setDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d/M/yyyy').format(now);
    return formattedDate;
  }

  void initializeInvoiceNumber() async {
    nextInvoiceNumber = await getNextInvoiceNumber();
    notifyListeners();
  }

  // void setSelectedInvoiceType(String? type) {
  //   if (invoiceType != type) {
  //     invoiceType = type;
  //     if (type != null) {
  //       clientsController.fetchClientsBasedOnInvoiceType(invoiceType);
  //     }
  //     // Only notify if the value has changed
  //     notifyListeners();
  //   }
  // }

  Future<int> getNextInvoiceNumber() async {
    try {
      final response = await supabase.rpc('get_next_invoice_number');

      if (response != null && response is int) {
        return response;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (error) {
      print("Error fetching invoice number: $error");

      rethrow;
    }
  }

}
