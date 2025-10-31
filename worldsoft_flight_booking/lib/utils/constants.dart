class ApiConstants {
  static const String baseUrl = 'https://api.worldsoftgroup.com/api';
}

class AppConstants {
  static const String appName = 'Airaissia Move';
  static const String appVersion = '1.0.0';
  
  static const Map<String, String> cabinClasses = {
    'Y': 'Economy',
    'C': 'Business',
    'F': 'First Class',
    'W': 'Premium Economy',
  };
  
  static const Map<int, String> tripTypes = {
    1: 'One Way',
    2: 'Round Trip',
    3: 'Multi City',
  };
}