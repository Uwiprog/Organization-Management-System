class AgendaKegiatan {
  final String id;
  final String judul;
  final String kategori;
  final String tanggal;
  final String lokasi;
  final String status;

  const AgendaKegiatan({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.tanggal,
    required this.lokasi,
    this.status = 'Terjadwal',
  });

  factory AgendaKegiatan.fromJson(Map<String, dynamic> json) {
    return AgendaKegiatan(
      id: json['id'] as String,
      judul: json['judul'] as String,
      kategori: json['kategori'] as String,
      tanggal: json['tanggal'] as String,
      lokasi: json['lokasi'] as String,
      status: json['status'] as String? ?? 'Terjadwal',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'kategori': kategori,
      'tanggal': tanggal,
      'lokasi': lokasi,
      'status': status,
    };
  }
}