import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../model/salesman.dart';
import '../repository/user_supabase_repository.dart';

class UserController extends ChangeNotifier {
  final UserSupabaseRepository repository;

  SalesMan? currentUser;
  bool isLoading = false;
  String? errorMessage;

  UserController(this.repository);

  Future<void> fetchCurrentUser(BuildContext context) async {
    final local = AppLocalizations.of(context)!;

    isLoading = true;
    notifyListeners();

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
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching current user: $e");
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
