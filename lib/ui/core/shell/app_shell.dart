import 'package:flutter/material.dart';

import '../../home/home_screen.dart';
import '../../kelola_event/kelola_event_screen.dart';
import '../../qr/scan_qr_screen.dart';
import '../../forum/forum_screen.dart';
import '../../profile/profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const HomeScreen(),
      const ForumScreen(),
      KelolaEventScreen(onBackToHome: () => setState(() => _currentIndex = 0)),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: SizedBox(
        height: 92,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 68,
              width: double.infinity,
              color: const Color(0xFF0052CC),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    screenIndex: 0,
                    icon: Icons.home_outlined,
                    label: 'Home',
                  ),
                  _buildNavItem(
                    screenIndex: 1,
                    icon: Icons.forum_outlined,
                    label: 'Forum',
                  ),
                  const SizedBox(width: 68),
                  _buildNavItem(
                    screenIndex: 2,
                    icon: Icons.event_note_outlined,
                    label: 'Kelola Event',
                  ),
                  _buildNavItem(
                    screenIndex: 3,
                    icon: Icons.person_outline,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ScanQrScreen()),
                  );
                },
                child: Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.qr_code_2,
                    color: Color(0xFF0052CC),
                    size: 36,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int screenIndex,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _currentIndex == screenIndex;
    return InkWell(
      onTap: () => setState(() => _currentIndex = screenIndex),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: 23,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
