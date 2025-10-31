class Passenger {
  final String firstName;
  final String lastName;
  final String passengerTitle;
  final DateTime birthday;
  final String gender;
  final String passportNumber;
  final DateTime expiryDate;
  final String nationality;
  final String email;
  final String phone;

  Passenger({
    required this.firstName,
    required this.lastName,
    required this.passengerTitle,
    required this.birthday,
    required this.gender,
    required this.passportNumber,
    required this.expiryDate,
    required this.nationality,
    required this.email,
    required this.phone,
  });
}

class PassengerGroup {
  final List<Passenger> adults;
  final List<Passenger> children;
  final List<Passenger> infants;

  PassengerGroup({
    required this.adults,
    required this.children,
    required this.infants,
  });

  int get totalPassengers => adults.length + children.length + infants.length;
}