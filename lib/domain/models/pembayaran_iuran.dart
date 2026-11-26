class PembayaranIuran {
  final String id;
  final String namaKegiatan;
  final double nominal;
  final String metodeBayar;
  final String tanggal;
  final String status;

  const PembayaranIuran({
    required this.id,
    required this.namaKegiatan,
    required this.nominal,
    this.metodeBayar = 'QRIS HMTI',
    required this.tanggal,
    this.status = 'Berhasil',
  });

  factory PembayaranIuran.fromJson(Map<String, dynamic> json) {
    return PembayaranIuran(
      id: json['id'] as String,
      namaKegiatan: json['namaKegiatan'] as String,
      nominal: (json['nominal'] as num).toDouble(),
      metodeBayar: json['metodeBayar'] as String? ?? 'QRIS HMTI',
      tanggal: json['tanggal'] as String,
      status: json['status'] as String? ?? 'Berhasil',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaKegiatan': namaKegiatan,
      'nominal': nominal,
      'metodeBayar': metodeBayar,
      'tanggal': tanggal,
      'status': status,
    };
  }

  PembayaranIuran copyWith({
    String? id,
    String? namaKegiatan,
    double? nominal,
    String? metodeBayar,
    String? tanggal,
    String? status,
  }) {
    return PembayaranIuran(
      id: id ?? this.id,
      namaKegiatan: namaKegiatan ?? this.namaKegiatan,
      nominal: nominal ?? this.nominal,
      metodeBayar: metodeBayar ?? this.metodeBayar,
      tanggal: tanggal ?? this.tanggal,
      status: status ?? this.status,
    );
  }
}