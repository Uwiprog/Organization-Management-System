import 'package:flutter/material.dart';

class GuideManual {
  final String id;
  final String tag;
  final Color tagBg;
  final Color tagColor;
  final String durasi;
  final String judul;
  final String ringkasan;
  final String langkah;
  final String ctaLabel;
  final IconData icon;

  const GuideManual({
    required this.id,
    required this.tag,
    required this.tagBg,
    required this.tagColor,
    required this.durasi,
    required this.judul,
    required this.ringkasan,
    required this.langkah,
    required this.ctaLabel,
    required this.icon,
  });
}

class UserGuideScreen extends StatefulWidget {
  const UserGuideScreen({super.key});

  @override
  State<UserGuideScreen> createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
  final _searchController = TextEditingController();
  String _selectedTopic = 'Semua';
  final Set<String> _expandedIds = {};

  final List<String> _topics = const [
    'Semua',
    'Cara Presensi',
    'Fitur Konsultasi',
    'Pembayaran Kas',
  ];

  final List<GuideManual> _guides = const [
    GuideManual(
      id: 'navigasi',
      tag: 'NAVIGASI',
      tagBg: Color(0xFFE0E7FF),
      tagColor: Color(0xFF0052CC),
      durasi: '2 mnt',
      judul: 'Cara Menggunakan Aplikasi HMTI',
      ringkasan:
          'Pahami 5 menu inti di navigation bar untuk memaksimalkan aktivitas keanggotaan...',
      langkah:
          '1. Buka Home untuk melihat kalender kegiatan dan event.\n2. Gunakan Forum untuk diskusi anggota.\n3. Tekan tombol QR di tengah untuk scan kehadiran.\n4. Masuk ke Kelola Event setelah SK terverifikasi.\n5. Atur akun di menu Profile.',
      ctaLabel: 'Baca Panduan Lengkap',
      icon: Icons.explore_outlined,
    ),
    GuideManual(
      id: 'presensi',
      tag: 'PRESENSI',
      tagBg: Color(0xFFFEF3C7),
      tagColor: Color(0xFFB45309),
      durasi: '1 mnt',
      judul: 'Cara Presensi Kegiatan & Event',
      ringkasan:
          'Langkah melakukan absensi digital mandiri saat rapat pleno, seminar, ataupun Makrab.',
      langkah:
          '1. Pastikan kamu berada di lokasi atau sesi kegiatan aktif.\n2. Ketuk tombol QR Code di bagian tengah navbar.\n3. Arahkan kamera ke QR panitia hingga terkonfirmasi hadir.',
      ctaLabel: 'Lihat Detail Presensi',
      icon: Icons.qr_code_scanner,
    ),
    GuideManual(
      id: 'konsultasi',
      tag: 'KONSULTASI',
      tagBg: Color(0xFFE0E7FF),
      tagColor: Color(0xFF0052CC),
      durasi: '3 mnt',
      judul: 'Cara Menggunakan Fitur Konsultasi',
      ringkasan:
          'Solusi curhat akademik, rekomendasi peminatan, konsultasi KRS, hingga persiapan...',
      langkah:
          '1. Buka fitur Konsultasi dari menu atau Pilihan Lain.\n2. Pilih topik atau pembina/pengurus tujuan.\n3. Kirim pertanyaan secara jelas dan pantau status balasan.',
      ctaLabel: 'Panduan Konsultasi',
      icon: Icons.support_agent,
    ),
    GuideManual(
      id: 'pembayaran',
      tag: 'KEUANGAN',
      tagBg: Color(0xFFDCFCE7),
      tagColor: Color(0xFF15803D),
      durasi: '2 mnt',
      judul: 'Pembayaran Iuran Kas & Makrab',
      ringkasan:
          'Tata cara verifikasi pelunasan kas bulanan dan iuran acara melalui QRIS resmi.',
      langkah:
          '1. Buka halaman Payment.\n2. Centang termin tagihan (misal Termin 1 HAKRAB 2026) pada tab Belum Dibayar.\n3. Tekan Bayar, pilih metode pembayaran, dan konfirmasi agar pindah ke Sudah Dibayar.',
      ctaLabel: 'Panduan Pembayaran',
      icon: Icons.account_balance_wallet_outlined,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matches(GuideManual item) {
    final q = _searchController.text.trim().toLowerCase();
    final matchSearch = q.isEmpty ||
        item.judul.toLowerCase().contains(q) ||
        item.ringkasan.toLowerCase().contains(q) ||
        item.tag.toLowerCase().contains(q);

    if (!matchSearch) return false;
    if (_selectedTopic == 'Semua') return true;
    if (_selectedTopic == 'Cara Presensi') return item.id == 'presensi';
    if (_selectedTopic == 'Fitur Konsultasi') return item.id == 'konsultasi';
    if (_selectedTopic == 'Pembayaran Kas') return item.id == 'pembayaran';
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _guides.where(_matches).toList();

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
            // Header Manual Book
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF0052CC), width: 1.5),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Guide & Panduan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Panduan resmi penggunaan aplikasi mobile HMTI',
                          style: TextStyle(fontSize: 11.5, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF0FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Color(0xFF0052CC),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari topik panduan... (misal: scan, kas)',
                hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'TOPIK POPULER',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _topics.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final topic = _topics[index];
                  final selected = _selectedTopic == topic;
                  return ChoiceChip(
                    label: Text(topic),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedTopic = topic),
                    selectedColor: const Color(0xFF0052CC),
                    backgroundColor: const Color(0xFFE8EEF8),
                    labelStyle: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : const Color(0xFF0052CC),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                    showCheckmark: false,
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            ...filtered.map((item) {
              final isExpanded = _expandedIds.contains(item.id);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F4FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item.icon,
                            color: const Color(0xFF0052CC),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: item.tagBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.tag,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: item.tagColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.schedule, size: 13, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          item.durasi,
                          style:
                              const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.judul,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.ringkasan,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        height: 1.35,
                      ),
                    ),
                    if (isExpanded) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F8FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.langkah,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.45,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isExpanded) {
                            _expandedIds.remove(item.id);
                          } else {
                            _expandedIds.add(item.id);
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            item.ctaLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0052CC),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 18,
                            color: const Color(0xFF0052CC),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 8),

            // Box Bantuan Admin Support
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3FC),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0052CC),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.headset_mic_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masih Mengalami Kendala?',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Hubungi Divisi Kominfo / Sekretariat HMTI untuk kendala akun atau bug aplikasi.',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.black54,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Menghubungi Admin Support HMTI (08.00 - 21.00 WIB)...',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0052CC),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline, size: 18),
                      label: const Text(
                        'Hubungi Admin Support',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, size: 8, color: Color(0xFFFFD700)),
                      SizedBox(width: 6),
                      Text(
                        'Respons aktif: 08.00 - 21.00 WIB',
                        style: TextStyle(fontSize: 10.5, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}