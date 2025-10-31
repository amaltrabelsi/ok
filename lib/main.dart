import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/flight_model.dart';
import 'providers/auth_provider.dart';
import 'providers/flight_provider.dart';
import 'screens/login_screen.dart';
import 'screens/search_screen.dart';
import 'screens/results_screen.dart';
import 'screens/booking_screen.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FlightProvider()), 
      ],
      child: MaterialApp(
        title: 'Airaissia Move',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const OnboardingScreen(),
        routes: {
          '/search': (context) => const SearchScreen(),
          '/results': (context) => const ResultsScreen(),
          '/booking': (context) {
            final flight = ModalRoute.of(context)!.settings.arguments as Flight;
            return BookingScreen(flight: flight);
          },
        },
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isAuthenticated) {
          final flightProvider = Provider.of<FlightProvider>(context, listen: false);
          if (auth.token != null && auth.token!.isNotEmpty) {
            flightProvider.updateToken(auth.token!);
          }

          return const SearchScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
