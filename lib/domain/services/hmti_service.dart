import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/agenda_kegiatan.dart';
import '../models/informasi_konsultasi.dart';
import '../models/pembayaran_iuran.dart';
import '../models/tugas_panitia.dart';

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);

  @override
  String toString() => message;
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

class HmtiService {
  static const _keyAgenda = 'hmti_v2_agenda';
  static const _keyTugas = 'hmti_v2_tugas';
  static const _keyKonsultasi = 'hmti_v2_konsultasi';
  static const _keyPayment = 'hmti_v2_payment';
  static const _keyOfflineMode = 'hmti_v2_offline_mode';
  static const _keyLoggedInUser = 'hmti_v2_logged_user';

  Future<bool> isOfflineMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOfflineMode) ?? false;
  }

  Future<void> setOfflineMode(bool offline) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOfflineMode, offline);
  }

  Future<String?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLoggedInUser);
  }

  Future<void> login(String nimOrEmail, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (await isOfflineMode()) {
      throw const NetworkException(
        'Tidak ada koneksi internet. Periksa jaringan lalu coba login lagi.',
      );
    }

    final cleanId = nimOrEmail.trim();
    if (cleanId.isEmpty || password.isEmpty) {
      throw const AuthException('NIM/Email dan password wajib diisi.');
    }

    if (password != 'hmti2026') {
      throw const AuthException(
        'Password salah! Gunakan password "hmti2026" untuk masuk.',
      );
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLoggedInUser, cleanId);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedInUser);
  }

  List<AgendaKegiatan> _defaultAgenda() => const [
        AgendaKegiatan(
          id: '1',
          judul: 'Rapat Pleno Pengurus HMTI',
          kategori: 'Rapat',
          tanggal: 'Hari Ini',
          lokasi: 'Sekretariat HMTI',
          status: 'Wajib Hadir',
        ),
        AgendaKegiatan(
          id: '2',
          judul: 'Workshop Flutter & Layered Architecture',
          kategori: 'Event',
          tanggal: 'Hari Ini',
          lokasi: 'Lab Komputer 2',
          status: 'Berlangsung',
        ),
        AgendaKegiatan(
          id: '3',
          judul: 'Briefing Kaderisasi & Pemantauan',
          kategori: 'Divisi',
          tanggal: 'Besok',
          lokasi: 'Gedung B',
          status: 'Terjadwal',
        ),
        AgendaKegiatan(
          id: '4',
          judul: 'Evaluasi Program Kerja Bulanan',
          kategori: 'Rapat',
          tanggal: 'Lusa',
          lokasi: 'Ruang Rapat Gedung B',
          status: 'Terjadwal',
        ),
        AgendaKegiatan(
          id: '5',
          judul: 'Kunjungan Industri & Tech Sharing',
          kategori: 'Event',
          tanggal: 'Minggu Depan',
          lokasi: 'Bandung',
          status: 'Persiapan',
        ),
      ];

  List<TugasPanitia> _defaultTugas() => const [
        TugasPanitia(
          id: '1',
          judul: 'Cetak & Finalisasi Proposal HAKRAB 2026',
          penanggungJawab: 'Divisi Kaderisasi',
          deadline: 'Hari Ini',
          isSelesai: false,
        ),
        TugasPanitia(
          id: '2',
          judul: 'Revisi Desain Banner & Backdrop Kegiatan',
          penanggungJawab: 'Publikasi & Dokumentasi',
          deadline: 'Besok',
          isSelesai: false,
        ),
        TugasPanitia(
          id: '3',
          judul: 'Konfirmasi Rundown & Pemateri Tamu',
          penanggungJawab: 'Seksi Acara',
          deadline: 'Besok',
          isSelesai: false,
        ),
        TugasPanitia(
          id: '4',
          judul: 'Surat Izin Peminjaman Ruang Gedung B',
          penanggungJawab: 'Humas',
          deadline: 'Selesai',
          isSelesai: true,
        ),
        TugasPanitia(
          id: '5',
          judul: 'Rekap Rencana Anggaran Biaya (RAB)',
          penanggungJawab: 'Bendahara',
          deadline: '2 Hari Lagi',
          isSelesai: false,
        ),
      ];

  List<InformasiKonsultasi> _defaultKonsultasi() => const [
        InformasiKonsultasi(
          id: '1',
          namaDosen: 'Pembina HMTI',
          topik: 'Persetujuan Proposal & Tema HAKRAB 2026',
          jadwal: 'Kamis, 14.00 WIB',
          status: 'Disetujui',
        ),
        InformasiKonsultasi(
          id: '2',
          namaDosen: 'Kaprodi Teknik Informatika',
          topik: 'Sinkronisasi Program Kerja & Akademik',
          jadwal: 'Jumat, 10.00 WIB',
          status: 'Menunggu',
        ),
        InformasiKonsultasi(
          id: '3',
          namaDosen: 'Dosen Pendamping Kemahasiswaan',
          topik: 'Evaluasi LPJ Kegiatan Organisasi',
          jadwal: 'Senin, 13.00 WIB',
          status: 'Revisi',
        ),
        InformasiKonsultasi(
          id: '4',
          namaDosen: 'Pembina HMTI',
          topik: 'Pengajuan Pendanaan & Administrasi',
          jadwal: 'Selasa, 11.00 WIB',
          status: 'Disetujui',
        ),
        InformasiKonsultasi(
          id: '5',
          namaDosen: 'Koordinator Lab Informatika',
          topik: 'Peminjaman Perangkat Praktikum & Workshop',
          jadwal: 'Rabu, 09.30 WIB',
          status: 'Selesai',
        ),
      ];

  Future<List<AgendaKegiatan>> fetchAgenda() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final prefs = await SharedPreferences.getInstance();
    final offline = prefs.getBool(_keyOfflineMode) ?? false;
    final raw = prefs.getString(_keyAgenda);

    if (offline) {
      if (raw != null) {
        final decoded = jsonDecode(raw) as List<dynamic>;
        return decoded
            .map((e) => AgendaKegiatan.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const NetworkException(
        'Tidak ada koneksi internet dan belum ada data agenda tersimpan.',
      );
    }

    if (raw != null) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => AgendaKegiatan.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    final initial = _defaultAgenda();
    await saveAgenda(initial);
    return initial;
  }

  Future<void> saveAgenda(List<AgendaKegiatan> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _keyAgenda,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<TugasPanitia>> fetchTugas() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final prefs = await SharedPreferences.getInstance();
    final offline = prefs.getBool(_keyOfflineMode) ?? false;
    final raw = prefs.getString(_keyTugas);

    if (offline) {
      if (raw != null) {
        final decoded = jsonDecode(raw) as List<dynamic>;
        return decoded
            .map((e) => TugasPanitia.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const NetworkException(
        'Tidak ada koneksi internet dan belum ada data checklist tersimpan.',
      );
    }

    if (raw != null) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => TugasPanitia.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    final initial = _defaultTugas();
    await saveTugas(initial);
    return initial;
  }

  Future<void> saveTugas(List<TugasPanitia> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _keyTugas,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<InformasiKonsultasi>> fetchKonsultasi() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final prefs = await SharedPreferences.getInstance();
    final offline = prefs.getBool(_keyOfflineMode) ?? false;
    final raw = prefs.getString(_keyKonsultasi);

    if (offline) {
      if (raw != null) {
        final decoded = jsonDecode(raw) as List<dynamic>;
        return decoded
            .map((e) => InformasiKonsultasi.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const NetworkException(
        'Tidak ada koneksi internet dan belum ada info konsultasi tersimpan.',
      );
    }

    if (raw != null) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => InformasiKonsultasi.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    final initial = _defaultKonsultasi();
    await saveKonsultasi(initial);
    return initial;
  }

  Future<void> saveKonsultasi(List<InformasiKonsultasi> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _keyKonsultasi,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<PembayaranIuran>> fetchRiwayatPembayaran() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyPayment);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => PembayaranIuran.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PembayaranIuran> prosesPembayaran({
    required String namaKegiatan,
    required double nominal,
    required String metodeBayar,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (await isOfflineMode()) {
      throw const NetworkException(
        'Tidak ada koneksi internet. Pembayaran gagal diproses.',
      );
    }

    final now = DateTime.now();
    final minuteStr = now.minute.toString().padLeft(2, '0');
    final newPayment = PembayaranIuran(
      id: 'PAY-${now.millisecondsSinceEpoch}',
      namaKegiatan: namaKegiatan,
      nominal: nominal,
      metodeBayar: metodeBayar,
      tanggal: 'Hari Ini, ${now.hour}:$minuteStr',
      status: 'Berhasil',
    );

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyPayment);
    final List<dynamic> list = raw != null ? jsonDecode(raw) as List<dynamic> : [];
    list.insert(0, newPayment.toJson());
    await prefs.setString(_keyPayment, jsonEncode(list));

    return newPayment;
  }
}