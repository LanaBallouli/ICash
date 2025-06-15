import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../l10n/app_localizations.dart';
import '../model/salesman.dart';
import '../repository/user_supabase_repository.dart';

class UserController extends ChangeNotifier {
  final UserSupabaseRepository repository;

  SalesMan? currentUser;

  UserController(this.repository);

  Future<void> fetchCurrentUser(BuildContext context) async {
    final local = AppLocalizations.of(context)!;

    try {
      final supabaseUser = Supabase.instance.client.auth.currentUser;

      if (supabaseUser == null) {
        throw Exception(local.user_not_found);
      }

      final userFromDb = await repository.getUserById(supabaseUser.id);

      if (userFromDb == null) {
        throw Exception(local.user_not_found_in_db);
      }

      currentUser = userFromDb;
      notifyListeners();
    } catch (e) {
      print("Error fetching current user: $e");
    }
  }
}