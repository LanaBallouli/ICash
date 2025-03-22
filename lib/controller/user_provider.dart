import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  String? _userName;
  int? userId;

  String? get userName => _userName;

  Future<void> fetchUserName() async {
    try {
      final email = supabase.auth.currentUser?.email;

      if (email != null) {
        final response = await supabase
            .from('users')
            .select('full_name')
            .eq('email', email)
            .single();

        _userName = response['full_name'];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  Future<void> fetchUserId() async {
    try {
      final email = supabase.auth.currentUser?.email;

      if (email != null) {
        final response = await supabase
            .from('users')
            .select('id')
            .eq('email', email)
            .single();

        userId = response['id'];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}