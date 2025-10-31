import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final bool showParticles;
  final bool showGradient;
  
  const AnimatedBackground({
    super.key, 
    required this.child,
    this.showParticles = true,
    this.showGradient = true,
  });
  
  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> 
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _particleController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Gradient animation controller
    _gradientController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat(reverse: true);
    
    // Particle animation controller
    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _gradientAnimation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _gradientController,
      curve: Curves.easeInOut,
    ));
    
    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_gradientAnimation, _particleAnimation]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: widget.showGradient ? _buildDynamicGradient() : null,
            color: widget.showGradient ? null : AppColors.background,
          ),
          child: Stack(
            children: [
              // Animated particles
              if (widget.showParticles) ..._buildParticles(),
              
              // Main content
              widget.child,
            ],
          ),
        );
      },
    );
  }

  LinearGradient _buildDynamicGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.background,
        AppColors.backgroundSecondary.withOpacity(0.8 + _gradientAnimation.value * 0.2),
        AppColors.surfaceLight.withOpacity(0.6 + _gradientAnimation.value * 0.1),
      ],
      stops: const [0.0, 0.5, 1.0],
      transform: GradientRotation(_gradientAnimation.value * 0.05),
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(8, (index) {
      final double delay = index * 0.125;
      final double animationValue = (_particleAnimation.value + delay) % 1.0;
      
      return Positioned(
        left: (index * 12.5) % MediaQuery.of(context).size.width,
        top: MediaQuery.of(context).size.height * (0.2 + (animationValue * 0.6)),
        child: Opacity(
          opacity: (1.0 - animationValue) * 0.3,
          child: Container(
            width: 4 + (index % 3) * 2,
            height: 4 + (index % 3) * 2,
            decoration: BoxDecoration(
              color: _getParticleColor(index),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _getParticleColor(index).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color _getParticleColor(int index) {
    final colors = [
      AppColors.primary.withOpacity(0.6),
      AppColors.accentBlue.withOpacity(0.4),
      AppColors.accentTeal.withOpacity(0.5),
      AppColors.accentPurple.withOpacity(0.3),
    ];
    return colors[index % colors.length];
  }
}