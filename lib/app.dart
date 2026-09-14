import 'package:flutter/material.dart';

import 'features/auth/presentation/login_screen.dart';

class AppColors {
  static const navy = Color(0xFF1B3A6B);
  static const ink = Color(0xFF0F1C3F);
  static const mist = Color(0xFFF5F7FB);
  static const muted = Color(0xFF6B7A9E);
}

class VehiclePassportApp extends StatelessWidget {
  const VehiclePassportApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Vehicle Passport',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
    ),
    home: const LoginScreen(),
  );
}
