import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;

  set token(String? value) => _token = value;
  String? get token => _token;

  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/stream+json', 
       if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }
Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
  final cleanedBody = _cleanRequestBody(body);
  final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

  print('[POST] $url');
  print('Body: ${jsonEncode(cleanedBody)}');

  try {
    final response = await http
        .post(url, headers: _headers, body: jsonEncode(cleanedBody))
        .timeout(const Duration(seconds: 20));

    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is List) return decoded;
      if (decoded is Map) return decoded;
      throw Exception('Format de réponse inattendu: ${decoded.runtimeType}');
    } else if (response.statusCode == 406) {
      throw Exception('Erreur 406: Format non accepté.');
    } else {
      throw Exception('Erreur HTTP ${response.statusCode}: ${response.body}');
    }
  } on SocketException {
    throw Exception('Pas de connexion Internet');
  } on TimeoutException {
    throw Exception('Délai dépassé - réessaie plus tard');
  } catch (e) {
    print('Exception: $e');
    throw Exception('Erreur inattendue: $e');
  }
}
  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    print('[GET] $url');

    try {
      final response = await http
          .get(url, headers: _headers)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erreur HTTP ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Pas de connexion Internet');
    } on TimeoutException {
      throw Exception('Délai dépassé - réessaie plus tard');
    } catch (e) {
      throw Exception('Erreur inattendue: $e');
    }
  }
  Map<String, dynamic> _cleanRequestBody(Map<String, dynamic> body) {
    final cleaned = <String, dynamic>{};
    body.forEach((key, value) {
      if (value == null) return;
      if (value is String && value.trim().isEmpty) return;
      if (value is List && value.isEmpty) return;
      cleaned[key] = value;
    });
    return cleaned;
  }
}
