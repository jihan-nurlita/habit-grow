import 'package:flutter/material.dart';
import 'package:habit_grow/pages/auth/login_page.dart';
import 'package:habit_grow/pages/auth/providers/auth_provider.dart';
import 'package:habit_grow/pages/home/home_page.dart';
import 'package:habit_grow/pages/splash/splash_page.dart';
import 'package:habit_grow/providers/focus_provider.dart';
import 'package:habit_grow/providers/habit_provider.dart';
import 'package:habit_grow/providers/theme_provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  /// wajib
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize bahasa indonesia
  await initializeDateFormatting(
    'id_ID',
    null,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..loadUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FocusProvider(),
        ),
      ],
      child: const HabitGrow(),
    ),
  );
}

class HabitGrow extends StatelessWidget {
  const HabitGrow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Grow',
      routes: {
        '/splash': (context) =>
            const SplashPage(), // 2. Daftarkan rute splash page
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
      // 3. UBAH 'home' menjadi SplashPage() agar pertama kali aplikasi dibuka memuat splash screen
      home: const SplashPage(),
    );
  }
}
