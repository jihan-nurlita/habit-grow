import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_grow/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Mengatur animasi fade-in untuk logo dan teks agar muncul perlahan
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // Timer untuk berpindah halaman secara otomatis setelah 3 detik
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Ganti '/' dengan rute halaman utama aplikasi kamu (misal: HomePage atau StatisticsPage)
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Konten Tengah: Logo & Judul Aplikasi
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container Lingkaran Logo (Meniru gaya ikon habit premium)
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons
                              .local_fire_department_rounded, // Ikon api streak habit pekat solid
                          size: 48,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Nama Aplikasi
                    Text(
                      "Habit Tracker",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey.shade900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Subtitle / Tagline
                    Text(
                      "Bangun konsistensi setiap hari",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Konten Bawah: Indikator Loading Tipis Elegan
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(theme.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Memuat data...",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
