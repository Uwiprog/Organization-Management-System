import '../models/agenda_kegiatan.dart';
import '../services/hmti_service.dart';

class AgendaRepository {
  final HmtiService _service;
  AgendaRepository(this._service);

  Future<bool> isOfflineMode() => _service.isOfflineMode();

  Future<void> setOfflineMode(bool value) => _service.setOfflineMode(value);

  Future<List<AgendaKegiatan>> getAgendaList() async {
    return await _service.fetchAgenda();
  }
}