import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalesRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<double> getDailySales() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final startOfDay = "$today 00:00:00";
      final endOfDay = "$today 23:59:59";

      final response = await _client
          .from('invoices')
          .select('total')
          .gte('creation_time', startOfDay)
          .lte('creation_time', endOfDay);

      if (response.isEmpty) return 0.0;

      double totalSales = 0.0;

      for (var item in response) {
        final dynamic rawTotal = item['total'];

        if (rawTotal is num) {
          totalSales += rawTotal.toDouble();
        } else if (rawTotal is String) {
          final parsed = double.tryParse(rawTotal);
          if (parsed != null) {
            totalSales += parsed;
          }
        }
      }

      return totalSales;
    } catch (e) {
      print("Error fetching daily sales: $e");
      return 0.0;
    }
  }

  Future<double> getMonthlySales({int? userId}) async {
    final now = DateTime.now();
    final fromDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
    final toDate = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 1, 0));

    try {
      final query = _client.from('invoices').select('total');

      if (userId != null) {
        query.eq('user_id', userId);
      }

      final response = await query
          .gte('creation_time', "$fromDate 00:00:00")
          .lte('creation_time', "$toDate 23:59:59");

      final List<dynamic> data = response;

      double totalSales = 0.0;

      for (var item in data) {
        final dynamic rawTotal = item['total'];

        if (rawTotal is num) {
          totalSales += rawTotal.toDouble();
        } else if (rawTotal is String) {
          final parsed = double.tryParse(rawTotal);
          if (parsed != null) {
            totalSales += parsed;
          }
        }
      }

      return totalSales;
    } catch (e) {
      print("Error fetching monthly sales: $e");
      return 0.0;
    }
  }}