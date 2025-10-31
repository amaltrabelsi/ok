import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class PassengerSelector extends StatefulWidget {
  final ValueChanged<PassengerCount> onCountChanged;
  final PassengerCount initialCount;
  final bool compact;

  const PassengerSelector({
    super.key,
    required this.onCountChanged,
    this.initialCount = const PassengerCount(),
    this.compact = false,
  });

  @override
  State<PassengerSelector> createState() => _PassengerSelectorState();
}

class PassengerCount {
  final int adults;
  final int children;
  final int infants;

  const PassengerCount({
    this.adults = 1,
    this.children = 0,
    this.infants = 0,
  });

  int get total => adults + children + infants;

  PassengerCount copyWith({
    int? adults,
    int? children,
    int? infants,
  }) {
    return PassengerCount(
      adults: adults ?? this.adults,
      children: children ?? this.children,
      infants: infants ?? this.infants,
    );
  }
}

class _PassengerSelectorState extends State<PassengerSelector> {
  late PassengerCount _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _updateCount(PassengerCount newCount) {
    setState(() {
      _count = newCount;
    });
    widget.onCountChanged(newCount);
  }

  void _showPassengerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text('Passagers', style: AppTextStyles.titleLarge),
              const SizedBox(height: 24),
              _PassengerTypeRow(
                title: 'Adultes (12+ ans)',
                subtitle: 'À partir de 12 ans',
                count: _count.adults,
                onIncrement: () =>
                    _updateCount(_count.copyWith(adults: _count.adults + 1)),
                onDecrement: () {
                  if (_count.adults > 1) {
                    _updateCount(_count.copyWith(adults: _count.adults - 1));
                  }
                },
                minCount: 1,
              ),
              const Divider(color: AppColors.divider, height: 32),
              _PassengerTypeRow(
                title: 'Enfants (2-11 ans)',
                subtitle: 'De 2 à 11 ans',
                count: _count.children,
                onIncrement: () =>
                    _updateCount(_count.copyWith(children: _count.children + 1)),
                onDecrement: () {
                  if (_count.children > 0) {
                    _updateCount(_count.copyWith(children: _count.children - 1));
                  }
                },
              ),
              const Divider(color: AppColors.divider, height: 32),
              _PassengerTypeRow(
                title: 'Bébés (0-2 ans)',
                subtitle: 'Moins de 2 ans',
                count: _count.infants,
                onIncrement: () {
                  if (_count.infants < _count.adults) {
                    _updateCount(
                        _count.copyWith(infants: _count.infants + 1));
                  }
                },
                onDecrement: () {
                  if (_count.infants > 0) {
                    _updateCount(
                        _count.copyWith(infants: _count.infants - 1));
                  }
                },
                maxCount: _count.adults,
              ),
              const SizedBox(height: 32),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.pop(context),
                    child: Center(
                      child: Text(
                        'Confirmer',
                        style:
                            AppTextStyles.labelLarge.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.compact) {
      return InkWell(
        onTap: _showPassengerDialog,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.people_alt_rounded,
                color: AppColors.primary, size: 20),
            const SizedBox(width: 6),
            Text('${_count.total} pax',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textPrimary)),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _showPassengerDialog,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Passagers',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(
                  '${_count.total} ${_count.total > 1 ? 'voyageurs' : 'voyageur'}',
                  style: AppTextStyles.bodyLarge
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.people_alt_rounded,
                  color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _PassengerTypeRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minCount;
  final int? maxCount;

  const _PassengerTypeRow({
    required this.title,
    required this.subtitle,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    this.minCount = 0,
    this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.bodyLarge),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: count > minCount
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: count > minCount ? onDecrement : null,
                icon: Icon(
                  Icons.remove_rounded,
                  color: count > minCount
                      ? AppColors.primary
                      : AppColors.textDisabled,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text('$count', style: AppTextStyles.titleMedium),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                color: (maxCount == null || count < maxCount!)
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed:
                    (maxCount == null || count < maxCount!) ? onIncrement : null,
                icon: Icon(
                  Icons.add_rounded,
                  color: (maxCount == null || count < maxCount!)
                      ? AppColors.primary
                      : AppColors.textDisabled,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
