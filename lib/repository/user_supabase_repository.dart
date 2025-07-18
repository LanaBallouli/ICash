import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/salesman.dart';

class UserSupabaseRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<SalesMan?> getUserById(String supabaseUserId) async {
    final response = await _client
        .from('salesmen')
        .select()
        .eq('supabase_uid', supabaseUserId)
        .single();

    if (response.isEmpty) return null;

    return SalesMan.fromJson(response);
  }}