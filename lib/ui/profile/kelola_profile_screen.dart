import 'package:flutter/material.dart';

class KelolaProfileScreen extends StatefulWidget {
  const KelolaProfileScreen({super.key});

  @override
  State<KelolaProfileScreen> createState() => _KelolaProfileScreenState();
}

class _KelolaProfileScreenState extends State<KelolaProfileScreen> {
  final _namaController = TextEditingController(text: 'M Dwi Haryanto');
  final _emailController =
      TextEditingController(text: 'mdwiharyanto96@gmail.com');
  final _waController = TextEditingController(text: '+62 896-2962-3475');
  final _tglLahirController = TextEditingController(text: '20/02/2005');
  final _alamatController = TextEditingController(
    text: 'Jl. Surya Kencana No. 45, Sukabumi',
  );

  String _selectedSemester = 'Semester 5';
  String _photoNote = 'Format JPG, PNG maks. 2MB';

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _waController.dispose();
    _tglLahirController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _pickPhoto() {
    setState(() {
      _photoNote = 'Foto profil dipilih • Format JPG, PNG maks. 2MB';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pemilih foto profil (JPG/PNG maks. 2MB) siap digunakan.'),
      ),
    );
  }

  void _saveProfile() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perubahan profil tersimpan & tersinkronisasi HMTI.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _namaController.text = 'M Dwi Haryanto';
      _emailController.text = 'mdwiharyanto96@gmail.com';
      _waController.text = '+62 896-2962-3475';
      _tglLahirController.text = '20/02/2005';
      _alamatController.text = 'Jl. Surya Kencana No. 45, Sukabumi';
      _selectedSemester = 'Semester 5';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perubahan dibatalkan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _namaController.text.trim().isEmpty
        ? 'Anggota HMTI'
        : _namaController.text.trim();

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
          children: [
            // Kartu Header Avatar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
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
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 44,
                        backgroundColor: Color(0xFFE0E7FF),
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Color(0xFF0052CC),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickPhoto,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0052CC),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.photo_camera,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified,
                        size: 18,
                        color: Color(0xFF0052CC),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'NIM: 20240040174',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF0FC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, size: 8, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'ANGGOTA AKTIF HMTI',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0052CC),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _photoNote,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Data Akademik Kampus
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 18,
                            color: Color(0xFF0052CC),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Data Akademik Kampus',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F3F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, size: 11, color: Colors.black54),
                            SizedBox(width: 4),
                            Text(
                              'Terverifikasi',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nomor Induk Mahasiswa (NIM)',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Terkunci otomatis',
                        style: TextStyle(fontSize: 10.5, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _buildLockedField(
                    icon: Icons.lock_outline,
                    value: '20240040174',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Program Studi',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildLockedField(
                    icon: Icons.apartment_outlined,
                    value: 'Teknik Informatika',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Angkatan',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _buildLockedField(
                              icon: Icons.calendar_today_outlined,
                              value: '2024',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Semester',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F3F8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedSemester,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Semester 3',
                                      child: Text(
                                        'Semester 3',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Semester 5',
                                      child: Text(
                                        'Semester 5',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Semester 7',
                                      child: Text(
                                        'Semester 7',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    if (v != null) {
                                      setState(() => _selectedSemester = v);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Data Pribadi & Kontak
            Container(
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
                  const Row(
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        size: 18,
                        color: Color(0xFF0052CC),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Data Pribadi & Kontak',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildInputLabel('Nama Lengkap'),
                  _buildEditableField(
                    controller: _namaController,
                    icon: Icons.person_outline,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  _buildInputLabel('Email Kampus / Kontak'),
                  _buildEditableField(
                    controller: _emailController,
                    icon: Icons.alternate_email,
                  ),
                  const SizedBox(height: 12),
                  _buildInputLabel('Nomor WhatsApp / HP'),
                  _buildEditableField(
                    controller: _waController,
                    icon: Icons.phone_android_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildInputLabel('Tanggal Lahir'),
                  _buildEditableField(
                    controller: _tglLahirController,
                    icon: Icons.calendar_today_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildInputLabel('Alamat Domisili'),
                  _buildEditableField(
                    controller: _alamatController,
                    icon: Icons.location_on_outlined,
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 16, color: Color(0xFF0052CC)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Perubahan data diri akan disinkronisasi langsung dengan pangkalan data sekretariat HMTI untuk keperluan administrasi dan presensi.',
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052CC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.save_outlined, size: 19),
                label: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: _resetForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEEF3FC),
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Batal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildLockedField({required IconData icon, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? 28 : 0),
          child: Icon(icon, size: 18, color: Colors.black54),
        ),
        filled: true,
        fillColor: const Color(0xFFF0F3F8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}