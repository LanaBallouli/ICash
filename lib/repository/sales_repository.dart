import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalesRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<double> getDailySales() async {
    final today = DateTime.now().toIso8601String().split('T').first;

    final response = await _client
        .from('invoices')
        .select('total')
        .eq('issue_date', today);

    final List<dynamic> salesList = response;

    double totalSales = 0.0;
    if (salesList.isNotEmpty) {
      totalSales = salesList.map((s) => s['total'] as double).sum;
    }

    return totalSales;
  }

  Future<double> getMonthlySales({int? userId}) async {
    final now = DateTime.now();
    final fromDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
    final toDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 1, 0));

    try {
      final query = _client
          .from('invoices')
          .select('total');

      if (userId != null) {
        query.eq('user_id', userId);
      }

      final response = await query
          .gte('created_at', fromDate)
          .lte('created_at', toDate);

      final List<dynamic> data = response;

      double totalSales = 0.0;
      if (data.isNotEmpty && data[0].containsKey('total')) {
        totalSales = data.map((row) => row['total'] as double).sum;
      }

      return totalSales;
    } catch (e) {
      print("Error fetching monthly sales: $e");
      return 0.0;
    }
  }
}