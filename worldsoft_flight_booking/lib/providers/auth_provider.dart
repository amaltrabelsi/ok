import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _error;
  AuthResponse? _user;
  double _balance = 0;
  String? get token => _user?.token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  AuthResponse? get user => _user;
  double get balance => _balance;
  bool get isAuthenticated => _user != null && _user!.token.isNotEmpty;

  Future<void> login(String username, String password, String accountCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = AuthRequest(
        username: username,
        password: password,
        accountCode: accountCode,
      );
      _user = await _authService.login(request);
      if (_user == null || _user!.token.isEmpty) {
        throw Exception("Token JWT manquant après la connexion.");
      }

      _balance = await _authService.checkBalance();
      print("Connexion réussie pour ${_user!.username}, solde: $_balance");

    } catch (e) {
      print("Erreur lors du login: $e");
      _error = e.toString();
      _user = null;
      _balance = 0;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> logout() async {
    try {
      _authService.logout();
      print("Déconnexion réussie.");
    } catch (e) {
      print("Erreur pendant la déconnexion: $e");
    } finally {
      _user = null;
      _balance = 0;
      _error = null;
      notifyListeners();
    }
  }
  Future<void> refreshBalance() async {
    if (!isAuthenticated) return;
    try {
      _balance = await _authService.checkBalance();
      print("Nouveau solde: $_balance");
      notifyListeners();
    } catch (e) {
      print("Erreur refreshBalance: $e");
      _error = e.toString();
    }
  }
}
