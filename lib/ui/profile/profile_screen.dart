import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import 'faq_screen.dart';
import 'kelola_profile_screen.dart';
import 'settings_screen.dart';
import 'user_guide_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Colors.black87, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: Color(0xFFB81D13),
                size: 38,
              ),
              const SizedBox(height: 12),
              const Text(
                'Serius Mau Log Out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFB81D13),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE60000),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black87,
                              width: 1.2,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black87,
                              width: 1.2,
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 44,
              left: 16,
              right: 16,
              bottom: 18,
            ),
            color: const Color(0xFF0052CC),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD700),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.shield,
                    size: 30,
                    color: Color(0xFF0052CC),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HMTI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.05,
                      ),
                    ),
                    Text(
                      'MANAGEMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.05,
                      ),
                    ),
                    Text(
                      'SYSTEM',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              children: [
                _buildMenuTile(
                  icon: Icons.person_add_alt_1_outlined,
                  iconBg: const Color(0xFFEAF0FC),
                  iconColor: const Color(0xFF0052CC),
                  label: 'Kelola Profile',
                  textColor: Colors.black87,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const KelolaProfileScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                _buildMenuTile(
                  icon: Icons.settings_outlined,
                  iconBg: const Color(0xFFEAF0FC),
                  iconColor: const Color(0xFF0052CC),
                  label: 'Settings',
                  textColor: Colors.black87,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                _buildMenuTile(
                  icon: Icons.menu_book_outlined,
                  iconBg: const Color(0xFFFFF3C4),
                  iconColor: const Color(0xFFD99B00),
                  label: 'User Guide',
                  textColor: Colors.black87,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const UserGuideScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                _buildMenuTile(
                  icon: Icons.help_outline_rounded,
                  iconBg: const Color(0xFFEAF0FC),
                  iconColor: const Color(0xFF0052CC),
                  label: 'FAQ',
                  textColor: Colors.black87,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FaqScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                _buildMenuTile(
                  icon: Icons.logout_rounded,
                  iconBg: const Color(0xFFFDE8E8),
                  iconColor: const Color(0xFFD92D20),
                  label: 'Log Out',
                  textColor: const Color(0xFFD92D20),
                  onTap: () => _showLogoutConfirmDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.black87,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}