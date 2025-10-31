import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight_model.dart';
import '../models/SearchParams.dart';

class FlightService {
  static const String baseUrl = "https://api.worldsoftgroup.com/api/flights";
  final String jwtToken;

  FlightService(this.jwtToken);

  // ===========================================================
  // ✅ Méthode POST générique
  // ===========================================================
  Future<List<Flight>> _postRequest(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/stream+json',
      'Authorization': 'Bearer $jwtToken',
    };

    print("🔹 POST $url");
    print("📦 Body envoyé : ${jsonEncode(body)}");

    final response = await http.post(url, headers: headers, body: jsonEncode(body));

    print("📡 HTTP ${response.statusCode}");
    print("📥 Response: ${response.body}");

    if (response.statusCode == 401) {
      throw Exception("⛔ Token JWT invalide ou expiré (401 Unauthorized).");
    }

    if (response.statusCode != 200) {
      throw Exception("Erreur API (${response.statusCode}): ${response.reasonPhrase ?? response.body}");
    }

    final data = jsonDecode(response.body);
    final List results = data is List ? data : [data];
    final List<Flight> flights = [];

    for (var item in results) {
      if (item['errors'] != null && item['errors'].isNotEmpty) {
        print("⚠️ Erreur API : ${item['errors'][0]['message']}");
        continue;
      }

      final List pricedModels = item['pricedItineraryNewModel'] ?? [];
      for (var p in pricedModels) {
        flights.add(Flight.fromJson(p));
      }
    }

    return flights;
  }

  // ===========================================================
  // 🔹 ONE-WAY / ROUND-TRIP
  // ===========================================================
  Future<List<Flight>> searchLowFare(SearchParams param) async {
    return _postRequest("AirLowFareSearch/searchTwo/${param.typeSearch}", param.toJson());
  }

  Future<List<Flight>> searchAvailability(SearchParams param) async {
    return _postRequest("AirAvailabilitySearch/searchTwo/${param.typeSearch}", param.toJson());
  }

  Future<List<Flight>> searchBrandedFare(SearchParams param) async {
    return _postRequest("AirBrandedFareSearch/searchTwo/${param.typeSearch}", param.toJson());
  }

  Future<List<Flight>> searchCalendarFare(SearchParams param) async {
    final body = {...param.toJson(), "calender": true};
    return _postRequest("AirCalendarFareSearch/searchTwo/${param.typeSearch}", body);
  }

  Future<List<Flight>> searchFareFamily(SearchParams param) async {
    return _postRequest("AirFareFamilySearch/searchTwo/${param.typeSearch}", param.toJson());
  }

  Future<List<Flight>> searchCalendarByBrand(SearchParams param) async {
    return _postRequest("AirCalendarByBrandSearch/searchTwo/${param.typeSearch}", param.toJson());
  }

  // ===========================================================
  // 🔹 MULTI-Destination (typeSearch = 3)
  // ===========================================================
  Future<List<Flight>> searchMultiDestination(
    List<Map<String, dynamic>> segments,
    SearchParams base,
  ) async {
    if (segments.isEmpty) {
      throw Exception("⚠️ Aucun segment fourni pour la recherche multi-destination.");
    }

    String formatDate(dynamic date) {
      if (date == null) return "";
      if (date is DateTime) {
        return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      } else if (date is String) {
        return date;
      }
      throw Exception("Date invalide : $date");
    }

    final Map<String, dynamic> body = {
      "classe": base.classe,
      "qteADT": base.qteADT,
      "qteCHD": base.qteCHD,
      "qteINF": base.qteINF,
      "refundable": base.refundable,
      "retourleVol1": base.retourleVol1,
      "typeSearch": 3,
      "calender": base.calender,
      "preferredAirlines": null,
      "typGds": base.typGds,
    };

    // ✅ Ajout jusqu'à 5 segments selon Swagger
    for (int i = 0; i < 5; i++) {
      if (i < segments.length) {
        final seg = segments[i];
        body["departVol${i + 1}"] = seg["from"];
        body["destinationVol${i + 1}"] = seg["to"];
        body["departleVol${i + 1}"] = formatDate(seg["date"]);
      } else {
        body["departVol${i + 1}"] = null;
        body["destinationVol${i + 1}"] = null;
        body["departleVol${i + 1}"] = null;
      }
    }

    print("✅ Body MultiDestination (complet): ${jsonEncode(body)}");

    return _postRequest("AirLowFareSearch/searchTwo/3", body);
  }
}
