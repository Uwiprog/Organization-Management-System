import 'package:flutter/material.dart';

class FaqEntry {
  final String id;
  final String kategori;
  final Color badgeBg;
  final Color badgeColor;
  final String pertanyaan;
  final String jawaban;
  final String? catatan;
  final IconData icon;

  const FaqEntry({
    required this.id,
    required this.kategori,
    required this.badgeBg,
    required this.badgeColor,
    required this.pertanyaan,
    required this.jawaban,
    this.catatan,
    required this.icon,
  });
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final _searchController = TextEditingController();
  String _selectedCat = 'Semua';
  final Set<String> _openIds = {'faq_1'};

  final List<String> _categories = const [
    'Semua',
    'Akun & Login',
    'Presensi & QR',
    'Event & SK',
    'Keuangan',
    'Konsultasi',
  ];

  final List<FaqEntry> _faqs = const [
    FaqEntry(
      id: 'faq_1',
      kategori: 'UMUM',
      badgeBg: Color(0xFFE0E7FF),
      badgeColor: Color(0xFF0052CC),
      pertanyaan: 'Kenapa HMTI Management System dibuat?',
      jawaban:
          'HMTI Management System dibuat untuk memudahkan mahasiswa dan pengurus HMTI dalam memanajemen kegiatan, memastikan transparansi iuran kas & event, memfasilitasi konsultasi akademik/karir, serta merekam presensi kegiatan secara digital dan real-time.',
      catatan: 'Platform terpadu satu pintu civitas Teknik Informatika.',
      icon: Icons.verified_user_outlined,
    ),
    FaqEntry(
      id: 'faq_2',
      kategori: 'PRESENSI & QR',
      badgeBg: Color(0xFFE0F2FE),
      badgeColor: Color(0xFF0369A1),
      pertanyaan: 'Bagaimana jika QR Code presensi tidak bisa discan?',
      jawaban:
          'Pastikan izin kamera sudah aktif dan pencahayaan cukup. Jika masih gagal, laporkan NIM ke panitia/sekretariat HMTI agar presensi diinput manual.',
      icon: Icons.qr_code_2,
    ),
    FaqEntry(
      id: 'faq_3',
      kategori: 'EVENT & SK',
      badgeBg: Color(0xFFFEF3C7),
      badgeColor: Color(0xFFB45309),
      pertanyaan:
          "Kenapa menu Kelola Event bertanda 'Akses Belum Tersedia' / SK Pending?",
      jawaban:
          'Menu Kelola Event khusus pengurus atau panitia yang Surat Keputusan (SK)-nya sudah terbit dan terverifikasi oleh admin HMTI.',
      icon: Icons.badge_outlined,
    ),
    FaqEntry(
      id: 'faq_4',
      kategori: 'KEUANGAN',
      badgeBg: Color(0xFFDCFCE7),
      badgeColor: Color(0xFF15803D),
      pertanyaan: 'Bagaimana cara konfirmasi pembayaran termin Makrab?',
      jawaban:
          'Masuk ke menu Payment, pilih termin yang ingin dibayar pada tab Belum Dibayar, tekan Bayar, pilih metode pembayaran, lalu konfirmasi agar otomatis tercatat di tab Sudah Dibayar.',
      icon: Icons.payments_outlined,
    ),
    FaqEntry(
      id: 'faq_5',
      kategori: 'KONSULTASI',
      badgeBg: Color(0xFFE0E7FF),
      badgeColor: Color(0xFF0052CC),
      pertanyaan: 'Siapa saja yang bisa membalas di menu Konsultasi?',
      jawaban:
          'Pengurus HMTI terkait, pembina/pendamping kegiatan, serta divisi yang menangani topik konsultasi tersebut.',
      icon: Icons.chat_bubble_outline,
    ),
    FaqEntry(
      id: 'faq_6',
      kategori: 'AKUN & LOGIN',
      badgeBg: Color(0xFFF3E8FF),
      badgeColor: Color(0xFF7E22CE),
      pertanyaan: 'Lupa kata sandi atau akun terblokir?',
      jawaban:
          'Gunakan tautan bantuan di halaman Login atau hubungi admin HMTI untuk reset kredensial akunmu.',
      icon: Icons.lock_reset,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matches(FaqEntry f) {
    final q = _searchController.text.trim().toLowerCase();
    final matchQ = q.isEmpty ||
        f.pertanyaan.toLowerCase().contains(q) ||
        f.jawaban.toLowerCase().contains(q);
    if (!matchQ) return false;
    if (_selectedCat == 'Semua') return true;
    return f.kategori.toUpperCase().contains(_selectedCat.toUpperCase());
  }

  void _askNewQuestion() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Ajukan Pertanyaan Baru',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Tulis pertanyaanmu seputar HMTI...',
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
                const SnackBar(
                  content: Text('Pertanyaan terkirim ke pengurus HMTI.'),
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _faqs.where(_matches).toList();

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
            // Banner FAQ HMTI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0052CC), Color(0xFF003B99)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.question_mark_rounded,
                      color: Color(0xFF0052CC),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FAQ HMTI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Pertanyaan yang Sering Diajukan seputar operasional, kas, dan presensi organisasi.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.5,
                            height: 1.35,
                          ),
                        ),
                      ],
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
                hintText: 'Cari pertanyaan atau kata kunci...',
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

            const SizedBox(height: 12),

            // Filter Kategori
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final selected = _selectedCat == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedCat = cat),
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

            ...filtered.map((faq) {
              final isOpen = _openIds.contains(faq.id);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
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
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        setState(() {
                          if (isOpen) {
                            _openIds.remove(faq.id);
                          } else {
                            _openIds.add(faq.id);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F4FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                faq.icon,
                                size: 18,
                                color: const Color(0xFF0052CC),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: faq.badgeBg,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      faq.kategori,
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w900,
                                        color: faq.badgeColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    faq.pertanyaan,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isOpen)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              faq.jawaban,
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.45,
                                color: Colors.black87,
                              ),
                            ),
                            if (faq.catatan != null) ...[
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F4FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.info_outline,
                                      size: 15,
                                      color: Color(0xFF0052CC),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        faq.catatan!,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 8),

            // Box Pertanyaan Belum Terjawab
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.help_outline_rounded,
                          color: Colors.black87,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pertanyaan kamu belum terjawab?',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13.5,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Tanyakan langsung ke Pengurus HMTI melalui chat konsultasi atau form pertanyaan internal.',
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
                      onPressed: _askNewQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0052CC),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.chat_outlined, size: 18),
                      label: const Text(
                        'Ajukan Pertanyaan Baru',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'HMTI Tech Division • v2.4.0 Live Helpdesk',
                style: TextStyle(fontSize: 10.5, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}