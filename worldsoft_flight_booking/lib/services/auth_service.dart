import '../services/api_service.dart';

class AuthService {
  final ApiService _api = ApiService();
  Future<AuthResponse> login(AuthRequest request) async {
    try {
      final response = await _api.post('/auth/b2b/login/token', request.toJson());
      if (response == null || response['token'] == null || response['token'].toString().isEmpty) {
        throw Exception("Token JWT manquant dans la réponse du serveur");
      }

      final authResponse = AuthResponse.fromJson(response);
      _api.token = authResponse.token;

      print("Authentification réussie pour ${authResponse.username}");
      return authResponse;
    } catch (e) {
      print("Erreur AuthService.login : $e");
      rethrow;
    }
  }
  Future<double> checkBalance() async {
    try {
      final response = await _api.get('/shared/reftiers/currentsolde');

      if (response == null || response['currentSolde'] == null) {
        throw Exception("Impossible de récupérer le solde du compte");
      }

      return (response['currentSolde'] as num).toDouble();
    } catch (e) {
      print("Erreur AuthService.checkBalance : $e");
      rethrow;
    }
  }
  void logout() {
    print("Déconnexion de l’utilisateur courant");
    _api.token = null;
  }
}

class AuthRequest {
  final String username;
  final String password;
  final String accountCode;

  AuthRequest({
    required this.username,
    required this.password,
    required this.accountCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'accountCode': accountCode,
    };
  }
}

class AuthResponse {
  final String token;
  final String tiersName;
  final String trUserName;
  final String address;
  final String email;
  final String username;
  final String lpays;

  AuthResponse({
    required this.token,
    required this.tiersName,
    required this.trUserName,
    required this.address,
    required this.email,
    required this.username,
    required this.lpays,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token']?.toString() ?? '',
      tiersName: json['tiersName']?.toString() ?? '',
      trUserName: json['trUserName']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      lpays: json['lpays']?.toString() ?? '',
    );
  }
}
