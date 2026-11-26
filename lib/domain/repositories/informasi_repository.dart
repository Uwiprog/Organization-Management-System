import '../models/informasi_konsultasi.dart';
import '../services/hmti_service.dart';

class InformasiRepository {
  final HmtiService _service;
  InformasiRepository(this._service);

  Future<List<InformasiKonsultasi>> getKonsultasiList() async {
    return await _service.fetchKonsultasi();
  }
}