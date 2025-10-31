import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class FlightCard extends StatefulWidget {
  final Flight flight;
  final VoidCallback onTap;
  final bool isSelected;

  const FlightCard({
    super.key,
    required this.flight,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  State<FlightCard> createState() => _FlightCardState();
}

class _FlightCardState extends State<FlightCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 360;
        
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 6 : 8),
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withOpacity(0.1),
                      blurRadius: (isSmallScreen ? 15 : 20) + _elevationAnimation.value,
                      offset: const Offset(0, 8),
                      spreadRadius: isSmallScreen ? 1 : 2,
                    ),
                    if (widget.isSelected)
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: isSmallScreen ? 12 : 15,
                        offset: const Offset(0, 4),
                        spreadRadius: isSmallScreen ? 0.5 : 1,
                      ),
                  ],
                  border: Border.all(
                    color: widget.isSelected ? AppColors.primary : AppColors.border,
                    width: widget.isSelected ? 2 : 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTapCancel: _onTapCancel,
                    borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                    child: Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                      child: Column(
                        children: [
                      // Modern header with airline and price
                      _buildModernHeader(),
                      
                          SizedBox(height: isSmallScreen ? 16 : 24),
                      
                      // Enhanced flight timeline with modern design
                      _buildModernFlightTimeline(),
                      
                          SizedBox(height: isSmallScreen ? 16 : 20),
                          
                          // Flight details with improved icons and layout
                          _buildModernFlightDetails(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildModernHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAirlineSection(),
        _buildPriceSection(),
      ],
    );
  }

  Widget _buildAirlineSection() {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.airlines_rounded, 
            color: AppColors.onPrimary, 
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.flight.airline,
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.success.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '4.8',
                    style: AppTextStyles.promoText.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppColors.sunsetGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentOrange.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'MEILLEUR PRIX',
            style: AppTextStyles.badgeText.copyWith(
              fontSize: 10,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.flight.fare.amount.toInt()} ${widget.flight.fare.currency}',
          style: AppTextStyles.priceLarge,
        ),
      ],
    );
  }

  Widget _buildModernFlightTimeline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.elevatedGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border.withOpacity(0.5),
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
      child: Row(
        children: [
          // Departure section
          Expanded(
            child: _buildAirportSection(
              time: widget.flight.departureTime,
              code: widget.flight.departureCode,
              name: widget.flight.departureName,
              isDeparture: true,
            ),
          ),
          
          // Flight path with duration and stops
          _buildFlightPath(),
          
          // Arrival section
          Expanded(
            child: _buildAirportSection(
              time: widget.flight.arrivalTime,
              code: widget.flight.arrivalCode,
              name: widget.flight.arrivalName,
              isDeparture: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirportSection({
    required String time,
    required String code,
    required String name,
    required bool isDeparture,
  }) {
    return Column(
      crossAxisAlignment: isDeparture ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: AppTextStyles.timeDisplay,
        ),
        const SizedBox(height: 6),
        Text(
          code,
          style: AppTextStyles.airportCode,
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: AppTextStyles.airportName,
          overflow: TextOverflow.ellipsis,
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
          Text(
            widget.flight.duration,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 2,
                width: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.3),
                      AppColors.accentBlue.withOpacity(0.6),
                      AppColors.accentTeal.withOpacity(0.3),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Positioned(
                left: 0,
                top: -6,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.flight_takeoff_rounded,
                    size: 8,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: -6,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.accentTeal,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentTeal.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.flight_land_rounded,
                    size: 8,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.flight.stops.toLowerCase() == 'direct' 
                  ? AppColors.successLight
                  : AppColors.warningLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.flight.stops.toLowerCase() == 'direct'
                    ? AppColors.success.withOpacity(0.3)
                    : AppColors.warning.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              widget.flight.stops,
              style: AppTextStyles.caption.copyWith(
                color: widget.flight.stops.toLowerCase() == 'direct'
                    ? AppColors.success
                    : AppColors.warning,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFlightDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDetailItem(
          Icons.airline_seat_recline_normal_rounded,
          widget.flight.cabin,
          AppColors.primary,
          'Classe',
        ),
        _buildDetailItem(
          Icons.luggage_rounded,
          widget.flight.baggage,
          AppColors.accentBlue,
          'Bagages',
        ),
        _buildDetailItem(
          widget.flight.refundable ? Icons.verified_rounded : Icons.block_rounded,
          widget.flight.refundable ? 'Remboursable' : 'Non remboursable',
          widget.flight.refundable ? AppColors.success : AppColors.error,
          'Politique',
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String text, Color color, String label) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon, 
            size: 20, 
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textTertiary,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}