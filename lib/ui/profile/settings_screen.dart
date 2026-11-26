import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotif = true;
  bool _presensiReminder = true;
  bool _forumUpdate = false;
  String _textSize = 'Normal';
  bool _darkTheme = false;
  bool _talkBack = false;
  String _language = 'Bahasa Indonesia (ID)';
  bool _twoFactor = false;

  void _changePasswordDialog() {
    final passCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Ubah Kata Sandi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: TextField(
          controller: passCtrl,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Masukkan kata sandi baru',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0052CC),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kata sandi diperbarui.')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengaturan aplikasi berhasil disimpan.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0052CC),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifikasi
            _buildSectionCard(
              icon: Icons.notifications_active_outlined,
              title: 'Notifikasi',
              subtitle: 'Kelola pemberitahuan kegiatan himpunan',
              children: [
                _buildSwitchRow(
                  title: 'Notifikasi Push',
                  subtitle: 'Pemberitahuan jadwal kegiatan & pengumuman baru',
                  value: _pushNotif,
                  onChanged: (v) => setState(() => _pushNotif = v),
                ),
                const SizedBox(height: 10),
                _buildSwitchRow(
                  title: 'Pengingat Presensi Event',
                  badge: 'PRIORITAS',
                  subtitle: 'Notifikasi 30 menit sebelum event dimulai',
                  value: _presensiReminder,
                  onChanged: (v) => setState(() => _presensiReminder = v),
                ),
                const SizedBox(height: 10),
                _buildSwitchRow(
                  title: 'Update Diskusi Forum',
                  subtitle: 'Pemberitahuan balasan di Forum HMTI',
                  value: _forumUpdate,
                  onChanged: (v) => setState(() => _forumUpdate = v),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Aksesibilitas & Tampilan
            _buildSectionCard(
              icon: Icons.palette_outlined,
              title: 'Aksesibilitas & Tampilan',
              subtitle: 'Kenyamanan membaca dan kontras visual',
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ukuran Teks (Text Size)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '$_textSize (100%)',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0052CC),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: ['Kecil', 'Normal', 'Besar'].map((opt) {
                          final active = _textSize == opt;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _textSize = opt),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: active
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  opt,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: active
                                        ? FontWeight.w900
                                        : FontWeight.w500,
                                    color: active
                                        ? const Color(0xFF0052CC)
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildSwitchRow(
                  title: 'Mode Gelap (Dark Theme)',
                  subtitle: 'Mengurangi kelelahan mata di malam hari',
                  value: _darkTheme,
                  onChanged: (v) => setState(() => _darkTheme = v),
                ),
                const SizedBox(height: 10),
                _buildSwitchRow(
                  title: 'TalkBack / Screen Reader',
                  subtitle: 'Optimasi pembaca suara untuk disabilitas netra',
                  value: _talkBack,
                  onChanged: (v) => setState(() => _talkBack = v),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Preferensi Bahasa
            _buildSectionCard(
              icon: Icons.language_outlined,
              title: 'Preferensi Bahasa',
              subtitle: 'Pilih bahasa pengantar antarmuka',
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    setState(() {
                      _language = _language == 'Bahasa Indonesia (ID)'
                          ? 'English (EN)'
                          : 'Bahasa Indonesia (ID)';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Text('🇮🇩', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _language,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const Text(
                                'Default sistem akademik',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Ubah >',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF0052CC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Keamanan Akun
            _buildSectionCard(
              icon: Icons.shield_outlined,
              title: 'Keamanan Akun',
              subtitle: 'Lindungi kredensial & data kepengurusan',
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _changePasswordDialog,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lock_reset, color: Color(0xFF0052CC)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ubah Kata Sandi (Change Password)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Terakhir diubah 45 hari yang lalu',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSwitchRow(
                  title: 'Autentikasi Dua Langkah (2FA)',
                  subtitle: 'Verifikasi kode OTP melalui email kampus',
                  value: _twoFactor,
                  onChanged: (v) => setState(() => _twoFactor = v),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Informasi & Dukungan
            _buildSectionCard(
              icon: Icons.info_outline,
              title: 'Informasi & Dukungan',
              subtitle: 'Dokumentasi legal & versi sistem',
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.verified_outlined, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Versi Aplikasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF0FC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'v2.4.0 (Build 2026)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0052CC),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.privacy_tip_outlined, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Kebijakan Privasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.chevron_right, size: 20, color: Colors.black54),
                  ],
                ),
                const Divider(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gavel_outlined, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Ketentuan Layanan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.chevron_right, size: 20, color: Colors.black54),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0FC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.school, color: Color(0xFF0052CC), size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Perubahan pengaturan disinkronkan otomatis dengan server BPH HMTI untuk keperluan presensi dan forum mahasiswa.',
                      style: TextStyle(fontSize: 11.5, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052CC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.save_outlined, size: 19),
                label: const Text(
                  'Simpan Pengaturan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: const Color(0xFF0052CC)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required String title,
    String? badge,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            activeTrackColor: const Color(0xFF0052CC),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}