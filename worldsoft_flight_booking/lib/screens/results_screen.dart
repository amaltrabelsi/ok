import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsoft_flight_booking/models/flight_model.dart';
import '../providers/flight_provider.dart';
import '../widgets/flight_card.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/animated_background.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<FlightProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Résultats de recherche',
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: MediaQuery.of(context).size.width < 360 ? 18 : 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width < 360 ? 6 : 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: MediaQuery.of(context).size.width < 360 ? 18 : 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width < 360 ? 8 : 16,
            ),
            child: IconButton(
              onPressed: () => _showFilterBottomSheet(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedBackground(
        showParticles: false,
        showGradient: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return flightProvider.isSearching
                ? _buildResponsiveLoadingWidget(constraints)
                : flightProvider.searchError != null
                    ? _buildResponsiveErrorWidget(flightProvider.searchError!, constraints)
                    : flightProvider.flights.isEmpty
                        ? _buildResponsiveEmptyWidget(constraints)
                        : _buildResponsiveResultsList(flightProvider, constraints);
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveErrorWidget(String error, BoxConstraints constraints) {
    final isSmallScreen = constraints.maxWidth < 360;
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isSmallScreen ? 60 : 80,
              height: isSmallScreen ? 60 : 80,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(isSmallScreen ? 30 : 40),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: isSmallScreen ? 30 : 40,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: isSmallScreen ? 16 : 24),
            Text(
              'Erreur de recherche',
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: isSmallScreen ? 20 : 24,
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            Text(
              error,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: isSmallScreen ? 14 : 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isSmallScreen ? 24 : 32),
            Container(
              height: isSmallScreen ? 44 : 50,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: Text(
                      'Retour',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveEmptyWidget(BoxConstraints constraints) {
    final isSmallScreen = constraints.maxWidth < 360;
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isSmallScreen ? 60 : 80,
              height: isSmallScreen ? 60 : 80,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(isSmallScreen ? 30 : 40),
              ),
              child: Icon(
                Icons.airplanemode_active_rounded,
                color: Colors.white,
                size: isSmallScreen ? 30 : 40,
              ),
            ),
            SizedBox(height: isSmallScreen ? 16 : 24),
            Text(
              'Aucun vol trouvé',
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: isSmallScreen ? 20 : 24,
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            Text(
              'Aucun vol ne correspond à vos critères de recherche.',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: isSmallScreen ? 14 : 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isSmallScreen ? 24 : 32),
            Container(
              height: isSmallScreen ? 44 : 50,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: Text(
                      'Nouvelle recherche',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveLoadingWidget(BoxConstraints constraints) {
    final isSmallScreen = constraints.maxWidth < 360;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isSmallScreen ? 60 : 80,
            height: isSmallScreen ? 60 : 80,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(isSmallScreen ? 30 : 40),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: isSmallScreen ? 15 : 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),
          Text(
            'Recherche en cours...',
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: isSmallScreen ? 20 : 24,
            ),
          ),
          SizedBox(height: isSmallScreen ? 8 : 12),
          Text(
            'Veuillez patienter pendant que nous recherchons les meilleures offres',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isSmallScreen ? 14 : 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }



  Widget _buildResponsiveResultsList(FlightProvider flightProvider, BoxConstraints constraints) {
    final isSmallScreen = constraints.maxWidth < 360;
    
    return Column(
      children: [
        // Results header with modern design
        Container(
          margin: EdgeInsets.all(isSmallScreen ? 12 : 20),
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.1),
                blurRadius: isSmallScreen ? 15 : 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: isSmallScreen 
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${flightProvider.flights.length} vols trouvés',
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Trouvez le vol parfait pour votre voyage',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildResponsiveSortButton(constraints),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${flightProvider.flights.length} vols trouvés',
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Trouvez le vol parfait pour votre voyage',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textTertiary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    _buildResponsiveSortButton(constraints),
                  ],
                ),
        ),
        
        // Flight results list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 20,
              vertical: isSmallScreen ? 8 : 12,
            ),
            itemCount: flightProvider.flights.length,
            itemBuilder: (context, index) {
              final flight = flightProvider.flights[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: isSmallScreen ? 8 : 12,
                ),
                child: FlightCard(
                  flight: flight,
                  isSelected: flightProvider.selectedFlight?.id == flight.id,
                  onTap: () {
                    flightProvider.selectFlight(flight);
                    _showFlightDetails(flight);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveSortButton(BoxConstraints constraints) {
    final isSmallScreen = constraints.maxWidth < 360;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16, 
        vertical: isSmallScreen ? 8 : 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sort_rounded,
            color: AppColors.primary,
            size: isSmallScreen ? 16 : 18,
          ),
          SizedBox(width: isSmallScreen ? 6 : 8),
          Text(
            'Tri: Prix',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
          SizedBox(width: isSmallScreen ? 2 : 4),
          Icon(
            Icons.arrow_drop_down_rounded,
            size: isSmallScreen ? 16 : 18,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Filtres et tri',
                  style: AppTextStyles.sectionTitle,
                ),
                const SizedBox(height: 24),
                // Filter options
                _buildFilterSection('Prix', [
                  'Tous les prix',
                  'Moins de 200€',
                  '200€ - 500€',
                  'Plus de 500€',
                ]),
                const SizedBox(height: 24),
                _buildFilterSection('Compagnie', [
                  'Toutes les compagnies',
                  'Air France',
                  'Lufthansa',
                  'Emirates',
                ]),
                const SizedBox(height: 24),
                _buildFilterSection('Escales', [
                  'Tous les vols',
                  'Direct uniquement',
                  '1 escale maximum',
                ]),
                const SizedBox(height: 32),
                // Apply button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Navigator.pop(context),
                      child: Center(
                        child: Text(
                          'Appliquer les filtres',
                          style: AppTextStyles.buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = option == options.first; // Default selection
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1,
                ),
              ),
              child: Text(
                option,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showFlightDetails(Flight flight) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.flight_rounded,
                        color: AppColors.onPrimary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Détails du vol',
                            style: AppTextStyles.sectionTitle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${flight.airline} • ${flight.flightNumber}',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Disponible',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Flight route
                      _buildFlightRouteCard(flight),
                      const SizedBox(height: 20),
                      
                      // Flight details
                      _buildFlightDetailsCard(flight),
                      const SizedBox(height: 20),
                      
                      // Price and booking
                      _buildPriceCard(flight),
                    ],
                  ),
                ),
              ),
              
              // Bottom action
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.divider,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prix total',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                          Text(
                            '${flight.fare.amount.toInt()} ${flight.fare.currency}',
                            style: AppTextStyles.priceLarge,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 56,
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                              context,
                              '/booking',
                              arguments: flight,
                            );
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Réserver',
                                  style: AppTextStyles.buttonText,
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: AppColors.onPrimary,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlightRouteCard(Flight flight) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.elevatedGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildAirportInfo(
                  flight.departureTime,
                  flight.departureCode,
                  flight.departureName,
                  true,
                ),
              ),
              _buildFlightPath(),
              Expanded(
                child: _buildAirportInfo(
                  flight.arrivalTime,
                  flight.arrivalCode,
                  flight.arrivalName,
                  false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Durée: ${flight.duration}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirportInfo(String time, String code, String name, bool isDeparture) {
    return Column(
      crossAxisAlignment: isDeparture ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: AppTextStyles.timeDisplay,
        ),
        const SizedBox(height: 4),
        Text(
          code,
          style: AppTextStyles.airportCode,
        ),
        const SizedBox(height: 2),
        Text(
          name,
          style: AppTextStyles.airportName,
          textAlign: isDeparture ? TextAlign.left : TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildFlightPath() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.flight_rounded,
              color: AppColors.onPrimary,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDetailsCard(Flight flight) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Compagnie', flight.airline, Icons.airlines_rounded),
          _buildDetailRow('Numéro de vol', flight.flightNumber, Icons.confirmation_number_rounded),
          _buildDetailRow('Date', '${flight.departureDate.day}/${flight.departureDate.month}/${flight.departureDate.year}', Icons.calendar_today_rounded),
          _buildDetailRow('Escales', flight.stops, Icons.flight_land_rounded),
          _buildDetailRow('Classe', flight.cabin, Icons.airline_seat_recline_normal_rounded),
          _buildDetailRow('Bagages', flight.baggage, Icons.luggage_rounded),
          _buildDetailRow('Avion', flight.aircraft, Icons.airplanemode_active_rounded),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(Flight flight) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.euro_rounded,
              color: AppColors.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prix total',
            style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.onPrimary.withOpacity(0.9),
                  ),
                ),
                Text(
                  '${flight.fare.amount.toInt()} ${flight.fare.currency}',
                  style: AppTextStyles.heroTitle.copyWith(
                    color: AppColors.onPrimary,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Meilleur prix',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}