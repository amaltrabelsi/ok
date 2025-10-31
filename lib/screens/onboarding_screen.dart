import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'images/onboarding1.png',
      'title': 'Trouvez les meilleurs vols',
      'subtitle':'Réservez vos vols facilement, où que vous soyez, pour voyager en toute liberté.',
      'gradient': [Color(0xFF6D5BFF), Color(0xFF8BE9FD)],
    },
    {
      'image': 'images/onboarding2.png',
      'title': 'Explorez le monde',
      'subtitle':
          'Découvrez de nouvelles destinations et vivez des expériences inoubliables.',
      'gradient': [Color.fromARGB(255, 243, 244, 244), Color.fromARGB(255, 89, 159, 229)],
    },
    {
      'image': 'images/onboarding3.png',
      'title': 'Voyagez en toute sérénité',
      'subtitle':
          'Des réservations simples, sécurisées et rapides, où que vous soyez.',
      'gradient': [Color(0xFFFF9A8B), Color(0xFFFF6A88)],
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutQuint,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: List<Color>.from(_pages[_currentPage]['gradient']),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];

                  return Column(
                    children: [
                      Flexible(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Image.asset(
                            page['image'],
                            key: ValueKey(page['image']),
                            height: size.height * 0.8,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 4,
                        child: ClipRect( 
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(36),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: const Offset(0, -5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          page['title'],
                                          style:
                                              AppTextStyles.heroTitle.copyWith(
                                            fontSize: 26,
                                            color: AppColors.textPrimary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          page['subtitle'],
                                          style: AppTextStyles.bodyLarge.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _buildDots(),
                                const SizedBox(height: 20),
                                _buildBottomButtons(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                top: 10,
                right: 16,
                child: TextButton(
                  onPressed: _goToLogin,
                  child: Text(
                    _currentPage == _pages.length - 1 ? '' : 'Passer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: _currentPage == index ? 30 : 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _currentPage == index
                ? AppColors.primary
                : AppColors.textTertiary.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    final isLast = _currentPage == _pages.length - 1;
    return ElevatedButton(
      onPressed: _nextPage,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        elevation: 6,
        shadowColor: AppColors.primary.withOpacity(0.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isLast ? "Commencer" : "Suivant",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isLast ? Icons.arrow_forward_ios : Icons.arrow_right_alt_rounded,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
    );
  }
}
