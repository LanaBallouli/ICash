import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sales/controller/user_provider.dart';
import 'package:test_sales/model/monthly_target.dart';

class MonthlyTargetController extends ChangeNotifier {
  String? selectedMonth;
  String? selectedYear;
  String? targetAmount;
  late UserProvider userProvider;
  final supabase = Supabase.instance.client;



  Future<bool> checkMonthlyTarget() async {
    try {
      final response =
          await supabase.from('monthly_targets').select('id').limit(1);

      return response.isNotEmpty;
    } catch (error) {
      print('Error checking monthly target: $error');
      return false;
    }
  }

  Future<void> insertMonthlyTarget(MonthlyTarget monthlyTarget) async {
    try {
      final jsonData = monthlyTarget.toJson();
      final response = await supabase.from('monthly_targets').insert(jsonData);

      print("Supabase Response: $response"); // Log the full response

      if (response == null) {
        throw Exception("Failed to insert data: Response is null");
      }

      // Check for errors in the response
      if (response is Map<String, dynamic> && response.containsKey('error')) {
        throw Exception(response['error']);
      }

      print('Data inserted successfully: ${response.data}');
    } catch (error) {
      print('Error inserting data: $error');
    }
  }

  void setSelectedMonth(String? month) {
    selectedMonth = month;
    notifyListeners();
  }

  void setSelectedYear(String? year) {
    selectedYear = year;
    notifyListeners();
  }

  void setTargetAmount(String? amount) {
    targetAmount = amount;
    notifyListeners();
  }
}
