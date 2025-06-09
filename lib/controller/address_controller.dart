import 'package:flutter/cupertino.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/repository/address_repository.dart';
import 'package:collection/collection.dart';

class AddressController extends ChangeNotifier {
  final AddressRepository repository;
  List<Address> addresses = [];
  bool isLoading = false;
  String? errorMessage;
  Address? address;

  AddressController(this.repository);

  // --- Fetch All Addresses ---
  Future<void> fetchAllAddresses() async {
    _setLoading(true);
    try {
      addresses = await repository.getAll();
      _clearError();
    } catch (e) {
      _setError("Failed to fetch addresses");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // --- Fetch Single Address by ID ---
  Future<Address?> fetchAddressById(int id) async {
    _setLoading(true);
    try {
      final Address fetched = await repository.getById(id);
      address = fetched;
      _clearError();
      return address;
    } catch (e) {
      _setError("Failed to load address with ID $id");
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // --- Save New or Update Existing Address ---
  Future<Address> saveAddress(Address address) async {
    _setLoading(true);
    try {
      final savedAddress = await repository.save(address);
      if (!addresses.any((a) => a.id == savedAddress.id)) {
        addresses.add(savedAddress);
      } else {
        final index = addresses.indexWhere((a) => a.id == savedAddress.id);
        addresses[index] = savedAddress;
      }
      _clearError();
      notifyListeners();
      return savedAddress;
    } catch (e) {
      _setError("Failed to save address");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // --- Update an Existing Address ---
  Future<Address> updateAddress(Address address) async {
    _setLoading(true);
    try {
      final updatedAddress = await repository.update(address);
      final index = addresses.indexWhere((a) => a.id == address.id);
      if (index != -1) {
        addresses[index] = updatedAddress;
      }
      _clearError();
      notifyListeners();
      return updatedAddress;
    } catch (e) {
      _setError("Failed to update address");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // --- Delete an Address ---
  Future<void> deleteAddress(int id) async {
    _setLoading(true);
    try {
      await repository.delete(id);
      addresses.removeWhere((a) => a.id == id);
      _clearError();
    } catch (e) {
      _setError("Failed to delete address");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // --- Helper Methods ---

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    errorMessage = null;
    notifyListeners();
  }

  Address? getAddressFromList(int? id) {
    return addresses.firstWhereOrNull((a) => a.id == id);
  }
}