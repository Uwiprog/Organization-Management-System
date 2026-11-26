class TugasPanitia {
  final String id;
  final String judul;
  final String penanggungJawab;
  final String deadline;
  final bool isSelesai;

  const TugasPanitia({
    required this.id,
    required this.judul,
    required this.penanggungJawab,
    this.deadline = 'Minggu Ini',
    this.isSelesai = false,
  });

  factory TugasPanitia.fromJson(Map<String, dynamic> json) {
    return TugasPanitia(
      id: json['id'] as String,
      judul: json['judul'] as String,
      penanggungJawab: json['penanggungJawab'] as String,
      deadline: json['deadline'] as String? ?? 'Minggu Ini',
      isSelesai: json['isSelesai'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'penanggungJawab': penanggungJawab,
      'deadline': deadline,
      'isSelesai': isSelesai,
    };
  }

  TugasPanitia copyWith({
    String? id,
    String? judul,
    String? penanggungJawab,
    String? deadline,
    bool? isSelesai,
  }) {
    return TugasPanitia(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      penanggungJawab: penanggungJawab ?? this.penanggungJawab,
      deadline: deadline ?? this.deadline,
      isSelesai: isSelesai ?? this.isSelesai,
    );
  }
}