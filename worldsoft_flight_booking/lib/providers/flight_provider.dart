import 'package:flutter/material.dart';
import '../services/flight_service.dart';
import '../models/flight_model.dart';
import '../models/SearchParams.dart';

class FlightProvider with ChangeNotifier {
  late FlightService _flightService;
  String? _jwtToken;

  FlightProvider({String? jwtToken}) {
    _jwtToken = jwtToken;
    _flightService = FlightService(jwtToken ?? '');
  }

  bool _isSearching = false;
  String? _searchError;
  List<Flight> _flights = [];
  Flight? _selectedFlight;

  bool get isSearching => _isSearching;
  String? get searchError => _searchError;
  List<Flight> get flights => _flights;
  Flight? get selectedFlight => _selectedFlight;

  // ===========================================================
  // 🔹 Recherche générique (LowFare, Calendar, etc.)
  // ===========================================================
  Future<void> searchFlightsByType(String apiType, SearchParams request) async {
    _isSearching = true;
    _searchError = null;
    notifyListeners();

    try {
      print("Démarrage recherche de type: $apiType avec token=$_jwtToken");

      switch (apiType.toLowerCase()) {
        case 'lowfare':
          _flights = await _flightService.searchLowFare(request);
          break;
        case 'availability':
          _flights = await _flightService.searchAvailability(request);
          break;
        case 'branded':
          _flights = await _flightService.searchBrandedFare(request);
          break;
        case 'calendar':
          _flights = await _flightService.searchCalendarFare(request);
          break;
        case 'family':
          _flights = await _flightService.searchFareFamily(request);
          break;
        case 'calendarbrand':
          _flights = await _flightService.searchCalendarByBrand(request);
          break;
        default:
          throw Exception("Type de recherche inconnu : $apiType");
      }

      print("✅ Recherche terminée : ${_flights.length} vols trouvés");
    } catch (e, stack) {
      _flights = [];
      _searchError = e.toString();
      print("❌ Erreur dans FlightProvider ($apiType): $e");
      print(stack);
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  // ===========================================================
  // 🔹 Recherche simple
  // ===========================================================
  Future<void> searchFlights(SearchParams request) async {
    await searchFlightsByType('lowfare', request);
  }

  // ===========================================================
  // 🔹 Recherche Multi-destination
  // ===========================================================
  Future<void> searchMultiDestination(
      List<Map<String, dynamic>> segments, SearchParams baseRequest) async {
    _isSearching = true;
    _searchError = null;
    notifyListeners();

    try {
      print("🌍 Démarrage recherche multi-destination...");
      _flights = await _flightService.searchMultiDestination(segments, baseRequest);
      print("✅ Recherche multi terminée : ${_flights.length} vols trouvés");
    } catch (e, stack) {
      _flights = [];
      _searchError = e.toString();
      print("❌ Erreur recherche multi-destination: $e");
      print(stack);
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  // ===========================================================
  // 🔹 Sélection et nettoyage
  // ===========================================================
  void selectFlight(Flight flight) {
    _selectedFlight = flight;
    notifyListeners();
  }

  void clearSelection() {
    _selectedFlight = null;
    notifyListeners();
  }

  void clearResults() {
    _flights = [];
    _searchError = null;
    notifyListeners();
  }

  // ===========================================================
  // 🔹 Mise à jour sécurisée du token JWT
  // ===========================================================
  void updateToken(String newToken) {
    if (newToken.isEmpty) return;
    _jwtToken = newToken;
    _flightService = FlightService(newToken);
    print("🔐 Nouveau token mis à jour dans FlightProvider");

    // ✅ Évite le crash “setState() during build”
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
