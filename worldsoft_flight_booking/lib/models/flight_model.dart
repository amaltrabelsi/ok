// 📄 flight_model.dart
class FlightSearchRequest {
  final String departVol1;
  final String destinationVol1;
  final String? departVol2;
  final String? destinationVol2;
  final String? departVol3;
  final String? destinationVol3;
  final String? departVol4;
  final String? destinationVol4;
  final String? departVol5;
  final String? destinationVol5;

  final String departLeVol1;
  final String? departLeVol2;
  final String? departLeVol3;
  final String? departLeVol4;
  final String? departLeVol5;
  final String? retourLeVol1;

  final String classe; // 'Y', 'C', 'F', 'W'
  final int qteADT;
  final int qteCHD;
  final int qteINF;
  final int typeSearch; // 1, 2, 3
  final String refundable; // 'O' ou 'N'
  final List<String> preferredAirlines;
  final bool calender; // ✅ conforme à l’API (avec E)
  final List<String> typGds; // ✅ choix G/L

  FlightSearchRequest({
    required this.departVol1,
    required this.destinationVol1,
    this.departVol2,
    this.destinationVol2,
    this.departVol3,
    this.destinationVol3,
    this.departVol4,
    this.destinationVol4,
    this.departVol5,
    this.destinationVol5,
    required this.departLeVol1,
    this.departLeVol2,
    this.departLeVol3,
    this.departLeVol4,
    this.departLeVol5,
    this.retourLeVol1,
    required this.classe,
    required this.qteADT,
    this.qteCHD = 0,
    this.qteINF = 0,
    required this.typeSearch,
    this.refundable = 'O',
    this.preferredAirlines = const [],
    this.calender = false, // ✅
    this.typGds = const ['G', 'L'], // ✅ par défaut
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'departVol1': departVol1,
      'destinationVol1': destinationVol1,
      if (departVol2 != null) 'departVol2': departVol2,
      if (destinationVol2 != null) 'destinationVol2': destinationVol2,
      if (departVol3 != null) 'departVol3': departVol3,
      if (destinationVol3 != null) 'destinationVol3': destinationVol3,
      if (departVol4 != null) 'departVol4': departVol4,
      if (destinationVol4 != null) 'destinationVol4': destinationVol4,
      if (departVol5 != null) 'departVol5': departVol5,
      if (destinationVol5 != null) 'destinationVol5': destinationVol5,

      'departleVol1': departLeVol1,
      if (departLeVol2 != null) 'departleVol2': departLeVol2,
      if (departLeVol3 != null) 'departleVol3': departLeVol3,
      if (departLeVol4 != null) 'departleVol4': departLeVol4,
      if (departLeVol5 != null) 'departleVol5': departLeVol5,
      if (retourLeVol1 != null) 'retourleVol1': retourLeVol1,

      'classe': classe,
      'qteADT': qteADT,
      'qteCHD': qteCHD,
      'qteINF': qteINF,
      'typeSearch': typeSearch,
      'refundable': refundable,
      'preferredAirlines': preferredAirlines,
      'calender': calender, // ✅ clé conforme API
      'typGds': typGds,
    };
    return body;
  }
}

//
// ==================== FLIGHT MODEL ====================
//
class Flight {
  final String id;
  final String airline;
  final String flightNumber;
  final String departureCode;
  final String arrivalCode;
  final String departureName;
  final String arrivalName;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String stops;
  final String aircraft;
  final String cabin;
  final String baggage;
  final Fare fare;
  final bool refundable;
  final String fareSourceCode;
  final String gds;

  Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureName,
    required this.arrivalName,
    required this.departureDate,
    required this.arrivalDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.aircraft,
    required this.cabin,
    required this.baggage,
    required this.fare,
    required this.refundable,
    required this.fareSourceCode,
    required this.gds,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    final itinerary = (json['originDestinationOptions'] != null &&
            (json['originDestinationOptions'] as List).isNotEmpty)
        ? (json['originDestinationOptions'] as List)[0]
        : <String, dynamic>{};

    final totalFare = (json['totalFare'] != null &&
            (json['totalFare'] as List).isNotEmpty)
        ? (json['totalFare'] as List)[0]
        : <String, dynamic>{};

    DateTime parseDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return DateTime.now();
      try {
        return DateTime.parse(dateStr);
      } catch (_) {
        return DateTime.now();
      }
    }

    return Flight(
      id: json['fareSourceCode'] ?? '',
      airline: _extractAirline(itinerary),
      flightNumber: _extractFlightNumber(itinerary),
      departureCode: itinerary['departureAirportLocationCode'] ?? '',
      arrivalCode: itinerary['arrivalAirportLocationCode'] ?? '',
      departureName: itinerary['departureAirportLocation'] ?? '',
      arrivalName: itinerary['arrivalAirportLocation'] ?? '',
      departureDate: parseDate(itinerary['departureDate']),
      arrivalDate: parseDate(itinerary['arrivalDate']),
      departureTime: itinerary['departureTime'] ?? '',
      arrivalTime: itinerary['arrivalTime'] ?? '',
      duration: itinerary['totalTime'] ?? '',
      stops: itinerary['nbStop']?.toString() ?? 'Direct',
      aircraft: itinerary['equipment']?.toString() ?? '',
      cabin: itinerary['cabin'] ?? 'Economy',
      baggage: itinerary['baggage'] ?? '1PC',
      fare: Fare.fromJson(totalFare),
      refundable: (json['refund']?.toString() ?? '0') != '0',
      fareSourceCode: json['fareSourceCode'] ?? '',
      gds: json['gds'] ?? '',
    );
  }

  static String _extractAirline(Map<String, dynamic> itinerary) {
    if (itinerary['airlineCodes'] != null &&
        (itinerary['airlineCodes'] as List).isNotEmpty) {
      final airlineList = itinerary['airlineCodes'] as List;
      if (airlineList.isNotEmpty && (airlineList[0] as List).isNotEmpty) {
        return airlineList[0][0] ?? 'Unknown';
      }
    }
    return 'Unknown';
  }

  static String _extractFlightNumber(Map<String, dynamic> itinerary) {
    if (itinerary['airlineCodes'] != null &&
        (itinerary['airlineCodes'] as List).isNotEmpty &&
        (itinerary['airlineCodes'][0] as List).length > 1) {
      final flightInfo = itinerary['airlineCodes'][0][1] ?? '';
      return flightInfo.toString().split(' ')[0];
    }
    return '';
  }
}

//
// ==================== FARE MODEL ====================
//
class Fare {
  final double amount;
  final String currency;
  final double baseFare;
  final double taxes;

  Fare({
    required this.amount,
    required this.currency,
    required this.baseFare,
    required this.taxes,
  });

  factory Fare.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return double.tryParse(value.toString()) ?? 0;
    }

    final amount = parseDouble(json['amount']);
    final baseFare = parseDouble(json['amountAchat'] ?? json['amount']);

    return Fare(
      amount: amount,
      currency: json['currencyCode'] ?? 'DZD',
      baseFare: baseFare,
      taxes: amount - baseFare,
    );
  }
}
