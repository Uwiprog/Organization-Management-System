import 'package:flutter/material.dart';

class PengurusItem {
  final String nama;
  final String nim;
  final String angkatan;
  final String jabatan;
  final String? roleBadge;
  final Color? badgeColor;

  const PengurusItem({
    required this.nama,
    required this.nim,
    required this.angkatan,
    required this.jabatan,
    this.roleBadge,
    this.badgeColor,
  });
}

class DivisiStruktural {
  final String id;
  final String nama;
  final String deskripsi;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final List<PengurusItem> anggota;

  const DivisiStruktural({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.anggota,
  });
}

class StrukturalScreen extends StatefulWidget {
  const StrukturalScreen({super.key});

  @override
  State<StrukturalScreen> createState() => _StrukturalScreenState();
}

class _StrukturalScreenState extends State<StrukturalScreen> {
  String _selectedFilter = 'Semua';
  final Set<String> _expandedIds = {'bph', 'kaderisasi'};

  // Sesuaikan data nama, NIM, dan angkatan dengan postingan IG @hmti_unsp
  final List<PengurusItem> _pimpinanUtama = const [
    PengurusItem(
      nama: 'Ketua Himpunan (Kahim)',
      nim: '20230040xxx',
      angkatan: "Angkatan '23",
      jabatan: 'KETUA HIMPUNAN',
      roleBadge: 'KAHIM',
      badgeColor: Color(0xFFFFD700),
    ),
    PengurusItem(
      nama: 'Wakil Ketua (Wahim)',
      nim: '20230040xxx',
      angkatan: "Angkatan '23",
      jabatan: 'WAKIL KETUA',
      roleBadge: 'WAHIM',
      badgeColor: Color(0xFF0052CC),
    ),
  ];

  final List<DivisiStruktural> _divisiList = const [
    DivisiStruktural(
      id: 'bph',
      nama: 'BPH (Badan Pengurus Harian)',
      deskripsi: 'Koordinasi Inti Kepengurusan',
      icon: Icons.groups_rounded,
      iconBg: Color(0xFFE0E7FF),
      iconColor: Color(0xFF0052CC),
      anggota: [
        PengurusItem(
          nama: 'Koordinator BPH',
          nim: '20230040xxx',
          angkatan: "Angkatan '23",
          jabatan: 'KOORDINATOR',
        ),
        PengurusItem(
          nama: 'Anggota BPH',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
    DivisiStruktural(
      id: 'sekretaris',
      nama: 'Sekretaris',
      deskripsi: 'Administrasi & Kesekretariatan',
      icon: Icons.edit_document,
      iconBg: Color(0xFFFEF3C7),
      iconColor: Color(0xFFD97706),
      anggota: [
        PengurusItem(
          nama: 'Sekretaris Umum',
          nim: '20230040xxx',
          angkatan: "Angkatan '23",
          jabatan: 'KOORDINATOR',
        ),
        PengurusItem(
          nama: 'Sekretaris II',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
    DivisiStruktural(
      id: 'bendahara',
      nama: 'Bendahara',
      deskripsi: 'Keuangan & Kas Himpunan',
      icon: Icons.account_balance_wallet_outlined,
      iconBg: Color(0xFFDCFCE7),
      iconColor: Color(0xFF15803D),
      anggota: [
        PengurusItem(
          nama: 'Bendahara Umum',
          nim: '20230040xxx',
          angkatan: "Angkatan '23",
          jabatan: 'KOORDINATOR',
        ),
        PengurusItem(
          nama: 'Bendahara II',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
    DivisiStruktural(
      id: 'kaderisasi',
      nama: 'Divisi Kaderisasi',
      deskripsi: 'Manajemen & Pemantauan Anggota',
      icon: Icons.diversity_3_rounded,
      iconBg: Color(0xFFFEF9C3),
      iconColor: Color(0xFFCA8A04),
      anggota: [
        PengurusItem(
          nama: 'M Dwi Haryanto',
          nim: '20240040174',
          angkatan: "Angkatan '24",
          jabatan: 'MANAJEMEN & PEMANTAUAN',
        ),
        PengurusItem(
          nama: 'Anggota Kaderisasi',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
    DivisiStruktural(
      id: 'litbang',
      nama: 'Divisi Litbang',
      deskripsi: 'Penelitian & Pengembangan',
      icon: Icons.science_outlined,
      iconBg: Color(0xFFE0E7FF),
      iconColor: Color(0xFF1D4ED8),
      anggota: [
        PengurusItem(
          nama: 'Koordinator Litbang',
          nim: '20230040xxx',
          angkatan: "Angkatan '23",
          jabatan: 'KOORDINATOR',
        ),
        PengurusItem(
          nama: 'Anggota Litbang',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
    DivisiStruktural(
      id: 'humas',
      nama: 'Divisi Humas',
      deskripsi: 'Hubungan Masyarakat & Eksternal',
      icon: Icons.campaign_outlined,
      iconBg: Color(0xFFFFE4E6),
      iconColor: Color(0xFFBE123C),
      anggota: [
        PengurusItem(
          nama: 'Koordinator Humas',
          nim: '20230040xxx',
          angkatan: "Angkatan '23",
          jabatan: 'KOORDINATOR',
        ),
        PengurusItem(
          nama: 'Anggota Humas',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
    DivisiStruktural(
      id: 'kominfo',
      nama: 'Divisi Kominfo',
      deskripsi: 'Komunikasi, Media & Informasi',
      icon: Icons.perm_media_outlined,
      iconBg: Color(0xFFE0F2FE),
      iconColor: Color(0xFF0369A1),
      anggota: [
        PengurusItem(
          nama: 'Koordinator Kominfo',
          nim: '20230040xxx',
          angkatan: "Angkatan '23",
          jabatan: 'KOORDINATOR',
        ),
        PengurusItem(
          nama: 'Anggota Kominfo',
          nim: '20240040xxx',
          angkatan: "Angkatan '24",
          jabatan: 'ANGGOTA',
        ),
      ],
    ),
  ];

  List<String> get _filterTabs {
    return [
      'Semua',
      ..._divisiList.map((d) => d.id == 'bph'
          ? 'BPH'
          : d.nama.replaceFirst('Divisi ', '')),
    ];
  }

  bool _matchesFilter(DivisiStruktural divisi) {
    if (_selectedFilter == 'Semua') return true;
    if (_selectedFilter == 'BPH') return divisi.id == 'bph';
    return divisi.nama.toLowerCase().contains(_selectedFilter.toLowerCase());
  }

  void _toggleExpand(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredDivisi = _divisiList.where(_matchesFilter).toList();
    final totalPengurus = _pimpinanUtama.length +
        _divisiList.fold<int>(0, (sum, d) => sum + d.anggota.length);

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
            // Banner Struktural Pengurus HMTI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0052CC), Color(0xFF003B99)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0052CC).withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'PERIODE 2026',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Struktural Pengurus HMTI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Himpunan Mahasiswa Teknik Informatika',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.account_tree_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Filter Chips Horizontal
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filterTabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tab = _filterTabs[index];
                  final isSelected = _selectedFilter == tab;
                  return ChoiceChip(
                    label: Text(tab),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedFilter = tab),
                    selectedColor: const Color(0xFF0052CC),
                    backgroundColor: const Color(0xFFE8EEF8),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF0052CC),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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

            const SizedBox(height: 20),

            // Pimpinan Utama (Kahim & Wahim)
            if (_selectedFilter == 'Semua') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pimpinan Utama',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${_pimpinanUtama.length} PENGURUS',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0052CC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (int i = 0; i < _pimpinanUtama.length; i++) ...[
                    if (i > 0) const SizedBox(width: 12),
                    Expanded(child: _buildPimpinanCard(_pimpinanUtama[i])),
                  ],
                ],
              ),
              const SizedBox(height: 22),
            ],

            // Struktur Divisi & Biro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Struktur Divisi & Biro',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$totalPengurus PENGURUS',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...filteredDivisi.map((divisi) {
              final isExpanded =
                  _selectedFilter != 'Semua' || _expandedIds.contains(divisi.id);
              return _buildDivisiCard(divisi, isExpanded);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPimpinanCard(PengurusItem item) {
    final badgeColor = item.badgeColor ?? const Color(0xFFFFD700);
    final isGold = badgeColor.toARGB32() == const Color(0xFFFFD700).toARGB32();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFFE8EEF8),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Color(0xFF0052CC),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  isGold ? Icons.star_rounded : Icons.verified_rounded,
                  size: 14,
                  color: isGold ? Colors.black87 : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: isGold ? const Color(0xFFFFF3C4) : const Color(0xFFE0E7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item.jabatan,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w900,
                color: isGold ? const Color(0xFF9A6700) : const Color(0xFF0052CC),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.nama,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${item.nim} • ${item.angkatan}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivisiCard(DivisiStruktural divisi, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _toggleExpand(divisi.id),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: divisi.iconBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(divisi.icon, color: divisi.iconColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          divisi.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${divisi.deskripsi} • ${divisi.anggota.length} Pengurus',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: divisi.anggota.map((anggota) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F8FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFDCE7FF),
                          child: Icon(
                            Icons.person,
                            size: 22,
                            color: Color(0xFF0052CC),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                anggota.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${anggota.nim} • ${anggota.angkatan}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            anggota.jabatan,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0052CC),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}