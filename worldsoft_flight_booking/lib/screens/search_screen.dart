import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/SearchParams.dart';
import '../providers/flight_provider.dart';
import '../widgets/passenger_selector.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/animated_background.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _tripType = 1;
  DateTime? _departureDate;
  DateTime? _returnDate;
  String _from = "ALG";
  String _to = "TUN";
  String _classe = "Y";
  String _refundable = "O";
  List<String> _typGds = ["G", "L"];
  PassengerCount _passengerCount = const PassengerCount();

  List<Map<String, dynamic>> _segments = [
    {"from": "TUN", "to": "CDG", "date": DateTime.now().add(const Duration(days: 10))}
  ];

  @override
  void initState() {
    super.initState();
    _departureDate = DateTime.now().add(const Duration(days: 10));
    _returnDate = _departureDate!.add(const Duration(days: 7));
  }

  String _formatDate(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  Future<void> _selectDate(BuildContext context, ValueChanged<DateTime> onSelect,
      [DateTime? initial]) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027, 12, 31),
    );
    if (picked != null) onSelect(picked);
  }

  Future<void> _searchFlights() async {
    final provider = Provider.of<FlightProvider>(context, listen: false);
    try {
      if (_tripType == 3) {
        final baseRequest = SearchParams(
          typeSearch: 3,
          qteADT: _passengerCount.adults,
          qteCHD: _passengerCount.children,
          qteINF: _passengerCount.infants,
          classe: _classe,
          calender: false,
          refundable: _refundable,
          typGds: _typGds,
        );

        final segments = _segments.map((s) {
          return {
            "from": s["from"],
            "to": s["to"],
            "date": s["date"] is DateTime
                ? _formatDate(s["date"])
                : s["date"].toString(),
          };
        }).toList();

        await provider.searchMultiDestination(segments, baseRequest);
        _showSnack("Recherche multi-destination lancée !");
      } else {
        final request = SearchParams(
          typeSearch: _tripType,
          departVol1: _from,
          destinationVol1: _to,
          departleVol1: _formatDate(_departureDate!),
          retourleVol1: _tripType == 2 ? _formatDate(_returnDate!) : null,
          qteADT: _passengerCount.adults,
          qteCHD: _passengerCount.children,
          qteINF: _passengerCount.infants,
          classe: _classe,
          calender: false,
          refundable: _refundable,
          typGds: _typGds,
        );

        await provider.searchFlightsByType('lowfare', request);
        _showSnack(
            "Recherche ${_tripType == 1 ? "aller simple" : "aller-retour"} envoyée !");
      }

      if (mounted) Navigator.pushNamed(context, "/results");
    } catch (e) {
      _showSnack("Erreur : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 380;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBackground(
        showParticles: true,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildWelcomeSection(),
              const SizedBox(height: 24),
              _buildTripTypeSelector(),
              const SizedBox(height: 20),
              if (_tripType != 3) _buildSingleOrRoundTripCard(),
              if (_tripType == 3) _buildMultiSegmentCard(),
              const SizedBox(height: 20),
              _buildPassengerAndClass(),
              const SizedBox(height: 32),
              _buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.9), AppColors.accentBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.flight_takeoff_rounded,
              color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenue à WorldSoft Air",
                  style: AppTextStyles.heroTitle.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Réservez vos vols au meilleur tarif, en toute simplicité ",
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _tripTypeButton("Aller simple", 1, Icons.flight_takeoff_rounded),
        _tripTypeButton("Aller-retour", 2, Icons.autorenew_rounded),
        _tripTypeButton("Multi", 3, Icons.alt_route_rounded),
      ],
    );
  }

  Widget _tripTypeButton(String label, int value, IconData icon) => ChoiceChip(
        showCheckmark: false,
        elevation: 2,
        avatar: Icon(
          icon,
          size: 18,
          color: _tripType == value
              ? AppColors.onPrimary
              : AppColors.textSecondary,
        ),
        label: Text(label),
        selected: _tripType == value,
        selectedColor: AppColors.primary,
        backgroundColor: Colors.white.withOpacity(0.85),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color:
              _tripType == value ? AppColors.onPrimary : AppColors.textPrimary,
        ),
        onSelected: (_) => setState(() => _tripType = value),
      );

  Widget _buildSingleOrRoundTripCard() => _buildGlassCard(
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _iataField("De (IATA)", _from, (v) => _from = v.toUpperCase()),
              _iataField("À (IATA)", _to, (v) => _to = v.toUpperCase()),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _dateField("Départ", _departureDate!, (d) {
                setState(() => _departureDate = d);
              }),
              if (_tripType == 2)
                _dateField("Retour", _returnDate!, (d) {
                  setState(() => _returnDate = d);
                }),
            ],
          ),
        ],
      );

  Widget _buildMultiSegmentCard() => _buildGlassCard(
        children: [
          Text("Segments du voyage",
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18)),
          const SizedBox(height: 10),
          ..._segments.asMap().entries.map((entry) {
            final i = entry.key;
            final seg = entry.value;
            return _buildGlassCard(
              padding: 12,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _iataField("De (IATA)", seg["from"],
                        (v) => seg["from"] = v.toUpperCase()),
                    _iataField("À (IATA)", seg["to"],
                        (v) => seg["to"] = v.toUpperCase()),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _dateField("Date", seg["date"], (d) {
                        setState(() => seg["date"] = d);
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: AppColors.error),
                      onPressed: () => setState(() => _segments.removeAt(i)),
                    ),
                  ],
                ),
              ],
            );
          }),
          const SizedBox(height: 8),
          Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un segment"),
              onPressed: () =>
                  setState(() => _segments.add({"from": "", "to": "", "date": DateTime.now()})),
            ),
          ),
        ],
      );

  Widget _buildPassengerAndClass() => _buildGlassCard(
        children: [
          PassengerSelector(
            onCountChanged: (c) => setState(() => _passengerCount = c),
            initialCount: _passengerCount,
            compact: false,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _classe,
            decoration: const InputDecoration(labelText: "Classe cabine"),
            items: const [
              DropdownMenuItem(value: "Y", child: Text("Économie")),
              DropdownMenuItem(value: "W", child: Text("Premium Economy")),
              DropdownMenuItem(value: "C", child: Text("Business")),
              DropdownMenuItem(value: "F", child: Text("First Class")),
            ],
            onChanged: (v) => setState(() => _classe = v!),
          ),
        ],
      );

  Widget _iataField(String label, String value, ValueChanged<String> onChanged) {
    return SizedBox(
      width: 160,
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateField(String label, dynamic date, ValueChanged<DateTime> onSelect) {
    final displayDate = date is DateTime
        ? "${date.day}/${date.month}/${date.year}"
        : date.toString();
    return InkWell(
      onTap: () => _selectDate(context, onSelect, date is DateTime ? date : null),
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Text(displayDate),
      ),
    );
  }

  Widget _buildGlassCard({required List<Widget> children, double padding = 16}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSearchButton() => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadowColor: AppColors.primary.withOpacity(0.4),
          elevation: 8,
        ),
        icon: const Icon(Icons.search, color: Colors.white),
        label: const Text(
          "Rechercher des vols",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: _searchFlights,
      );
}
