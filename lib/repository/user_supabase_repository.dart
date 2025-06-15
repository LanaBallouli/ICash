import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/salesman.dart';

class UserSupabaseRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<SalesMan?> getUserById(String userId) async {
    final response = await _client
        .from('salesmen')
        .select()
        .eq('user_id', userId)
        .single();

    if (response == null || response.isEmpty) return null;

    return SalesMan.fromJson(response as Map<String, dynamic>);
  }
}