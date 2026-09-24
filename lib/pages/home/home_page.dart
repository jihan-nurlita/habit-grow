import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_grow/pages/auth/providers/auth_provider.dart';
import 'package:habit_grow/pages/calendar/calendar_page.dart';
import 'package:habit_grow/pages/focus/focus_page.dart';
import 'package:habit_grow/pages/habit/habit_page.dart';
import 'package:habit_grow/pages/habit/widgets/habit_tile.dart';
import 'package:habit_grow/pages/profile/profile_page.dart';
import 'package:habit_grow/providers/focus_provider.dart';
import 'package:habit_grow/providers/habit_provider.dart';
import 'package:habit_grow/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final focusProvider = Provider.of<FocusProvider>(context);
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,

      /// =========================
      /// BOTTOM NAVBAR
      /// =========================
      bottomNavigationBar: const _BottomNavbar(currentIndex: 0),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =========================
              /// HEADER
              /// =========================
              Row(
                children: [
                  /// Avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.softColor,
                    child: Text(
                      auth.name.isNotEmpty ? auth.name[0].toUpperCase() : "U",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Pagi",
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.iconColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Text(
                          auth.name,
                          style: TextStyle(
                            color: theme.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Notification
                  Icon(
                    Icons.notifications_none_rounded,
                    color: theme.iconColor,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// =========================
              /// HERO PROGRESS CARD
              /// =========================
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.softColor,
                  borderRadius: BorderRadius.circular(24),
                  // Menambahkan shadow halus agar container terlihat lebih hidup
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    /// Progress Circle
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          /// Background Track
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 8, // Sedikit lebih tipis agar elegan
                              color: theme.borderColor.withOpacity(0.5),
                            ),
                          ),

                          /// Real Progress (Dibuat Rounded)
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: habitProvider.progressPercent,
                              strokeWidth: 8,
                              strokeCap: StrokeCap.round, // MEMBUAT UJUNG BULAT
                              color: theme.primaryColor,
                            ),
                          ),

                          Text(
                            "${(habitProvider.progressPercent * 100).toInt()}%",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: theme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    /// Text Progress
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Progress Hari Ini",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.textColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Sabtu, 23 Maret 2026",
                            style: GoogleFonts.poppins(
                              color: theme.iconColor.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Indikator teks kecil yang rapi
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${habitProvider.completedHabits}/${habitProvider.totalHabits} Habit Selesai",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// STATS CARD
              /// =========================
              Row(
                children: [
                  // 1. STATS STREAK
                  Expanded(
                    child: _buildStatsCard(
                      title: "Streak",
                      theme: theme,
                      value: habitProvider.currentStreak
                          .toString(), // Ambil dinamis dari provider
                      subtitle: "Hari",
                      icon: Icons.local_fire_department_rounded,
                      iconColor: Colors.orange,
                      iconBgColor: Colors.orange.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 2. STATS SELESAI TOTAL
                  Expanded(
                    child: _buildStatsCard(
                      title: "Selesai",
                      theme: theme,
                      value: habitProvider.completedHabits
                          .toString(), // Ambil total habit selesai
                      subtitle: "Total",
                      icon: Icons.check_circle_rounded,
                      iconColor: Colors.green,
                      iconBgColor: Colors.green.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 3. STATS FOKUS
                  Expanded(
                    child: _buildStatsCard(
                      theme: theme,
                      title: "Fokus",
                      value: focusProvider.totalFocusHours.toString(),
                      subtitle: "Jam",
                      icon: Icons.hourglass_top_rounded,
                      iconColor: theme.primaryColor,
                      iconBgColor: theme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// =========================
              /// TITLE HABIT
              /// =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Habit Hari Ini",
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HabitPage()),
                      );
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// =========================
              /// HABIT LIST
              /// =========================
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // JIKA JUMLAH HABIT LEBIH DARI 3, TETAP TAMPILKAN 3 SAJA
                itemCount: habitProvider.habits.length > 3
                    ? 3
                    : habitProvider.habits.length,
                itemBuilder: (context, index) {
                  final habit = habitProvider.habits[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: HabitTile(
                      icon: habit.icon,
                      title: habit.title,
                      subtitle: habit.subtitle,
                      schedule: "${habit.repeat} • ${habit.startTime}",
                      completed: habit.completed,
                      onTap: () {
                        habitProvider.toggleHabit(habit);
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// =========================
              /// FOCUS CARD
              /// =========================
              Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: theme.softColor,
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  Positioned(
                    bottom: 13,
                    right: 0,
                    child: Image.asset(
                      'assets/focus.png',
                      width: 237,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Focus Hari Ini',
                          style: GoogleFonts.poppins(
                            color: theme.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          focusProvider.currentMode.title,
                          style: GoogleFonts.poppins(
                            color: theme.iconColor.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          focusProvider.formattedTime,
                          style: GoogleFonts.poppins(
                            color: theme.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 90,
                          height: 37,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FocusPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Mulai',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// STATS CARD COMPONENT
  /// =========================
  Widget _buildStatsCard({
    required String title,
    required dynamic theme,
    required String value,
    required String subtitle,
    required IconData icon, // Tambahkan parameter ikon
    required Color iconColor, // Tambahkan warna ikon custom
    required Color iconBgColor, // Tambahkan latar belakang ikon
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Mini Icon Bulat di atas
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 10),

          /// Nilai Utama
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20, // Diperkecil sedikit agar muat di layar hp kecil
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
          const SizedBox(height: 2),

          /// Judul / Label
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),

          /// Subtitle Kecil
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const _BottomNavbar({
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return; // Mencegah reload halaman yang sama

        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HabitPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FocusPage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CalendarPage()),
            );
            break;
          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
            break;
        }
      },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.cardColor,
      selectedItemColor: theme.primaryColor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: const IconThemeData(
        size: 28,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.timer_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded), label: ''),
      ],
    );
  }
}
