class InformasiKonsultasi {
  final String id;
  final String namaDosen;
  final String topik;
  final String jadwal;
  final String status;

  const InformasiKonsultasi({
    required this.id,
    required this.namaDosen,
    required this.topik,
    this.jadwal = 'Menunggu Konfirmasi',
    required this.status,
  });

  factory InformasiKonsultasi.fromJson(Map<String, dynamic> json) {
    return InformasiKonsultasi(
      id: json['id'] as String,
      namaDosen: json['namaDosen'] as String,
      topik: json['topik'] as String,
      jadwal: json['jadwal'] as String? ?? 'Menunggu Konfirmasi',
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaDosen': namaDosen,
      'topik': topik,
      'jadwal': jadwal,
      'status': status,
    };
  }
}