# hmti_management_systemv2

**Tema:** Sistem Manajemen Organisasi, Kegiatan, dan Administrasi Mahasiswa Teknik Informatika (HMTI)

Kami memilih tema manajemen operasional dan administrasi organisasi HMTI karena kebutuhan anggota dan pengurus—mulai dari pemantauan agenda/event, pembayaran termin kegiatan, diskusi forum, hingga presensi QR—sering tersebar di banyak kanal. Dengan menyatukannya dalam satu aplikasi mobile berbasis Flutter, koordinasi internal himpunan menjadi lebih terstruktur, transparan, dan mudah dipantau.


 Data Utama: `Agenda` / `Event` & `PengurusItem` / `DivisiStruktural` (`AgendaRepository`, `StrukturalScreen`) Merepresentasikan entitas inti organisasi dan kegiatan: jadwal event (belum mulai / selesai), struktur kepengurusan HMTI (Kahim, Wahim, BPH, sekretaris, bendahara, dan divisi).
Data Aksi: `PaymentItem` (`PaymentScreen`), `Tugas` / `Checklist` (`TugasRepository`), `ForumMessage` (`ForumScreen`), & Aksi Presensi QR (`ScanQrScreen`) Mewakili data yang berinteraksi langsung dengan aksi pengguna: mencentang dan melunasi termin pembayaran (tersimpan ke `SharedPreferences`), mengirim pesan di forum, serta memproses presensi QR dan pengingat SK.
Data Informasi: `GuideManual` (`UserGuideScreen`), `FaqEntry` (`FaqScreen`), & Status/Informasi SK (`KelolaEventScreen`, `SettingsScreen`) | Menyediakan informasi referensi, panduan penggunaan aplikasi, jawaban pertanyaan umum (FAQ), serta status informasi SK dan preferensi pengaturan sistem.

Fitur Buatan Sendiri & Pengembangan

* Beranda (Home) dengan Kalender Satu Baris & Pilihan Lain: Menampilkan header HMTI, kalender satu baris tanggal interaktif, daftar event belum mulai dan sudah selesai, serta menu cepat **Payment**, **Konsultasi**, dan **Struktural** (lengkap dengan pimpinan utama, filter divisi, dan daftar divisi *expandable*).
* Pembayaran Termin Tersimpan (`PaymentScreen`): Mendukung tab **Belum Dibayar** dan **Sudah Dibayar**, pemilihan item dengan checkbox + hitung total otomatis, pemilihan metode pembayaran, serta penyimpanan status lunas persisten menggunakan `SharedPreferences` agar tetap tersimpan saat keluar halaman.
* Forum Diskusi (`ForumScreen`): Menyediakan status online, filter topik (`Semua`, `Coding Help`, `Event HMTI`, `Santai`), reaksi pesan, lampiran, serta input kirim pesan dengan bubble pesan keluar rata kanan.
* Kelola Event & Profile (`KelolaEventScreen`, `ProfileScreen`, `ScanQrScreen`): Menampilkan status akses berbasis SK (`SK PENDING`), menu lengkap di Profile (`Kelola Profile`, `Settings`, `User Guide`, `FAQ`) beserta dialog konfirmasi `Log Out`, serta alur permintaan izin kamera pada layar `Scan Code Presensi`.

Screenshot Setiap Tab
* **Login** <img width="940" height="1079" alt="Login" src="https://github.com/user-attachments/assets/fc46b31f-af61-4f07-a237-165a3c8fa616" />
* **Homepage** <img width="937" height="1081" alt="Home" src="https://github.com/user-attachments/assets/f03be710-85fb-426f-b744-965340a8ebda" />
* **Forum** <img width="933" height="1078" alt="Forum" src="https://github.com/user-attachments/assets/55f0cc63-f869-4048-a6ae-97e9f7cf8029" />
* **Scan Qr** <img width="936" height="1079" alt="Scan Qr" src="https://github.com/user-attachments/assets/f81146e8-e622-4d60-81fb-61e674cb51f9" />
* **Kelola Event** <img width="934" height="1079" alt="Kelola Event" src="https://github.com/user-attachments/assets/b324a011-c528-404d-83be-7cc1fc5e0912" />
* **Profile** <img width="935" height="1086" alt="Profile" src="https://github.com/user-attachments/assets/5d59305b-85de-473f-92e8-b5abb6b2209c" />

## Screenshot Beranda Sebelum & Sesudah Item Dicentang

* **Sebelum Dicentang:** <img width="936" height="1084" alt="payment Before Check" src="https://github.com/user-attachments/assets/32201f7d-6f1e-4b1e-a97d-74db3e7306c6" />
* **Sesudah Dicentang:** <img width="938" height="1084" alt="payment after check" src="https://github.com/user-attachments/assets/02ca75d7-3457-404c-bb07-70324f343d07" />

## Hasil `flutter test .`
<img width="1573" height="137" alt="Screenshot 2026-11-27 070659" src="https://github.com/user-attachments/assets/1d68c43b-74f2-4d18-bdf1-38ec3d4dbe9f" />

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
