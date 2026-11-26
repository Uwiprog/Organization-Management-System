import 'package:flutter/foundation.dart';
import '../../domain/models/agenda_kegiatan.dart';
import '../../domain/models/pembayaran_iuran.dart';
import '../../domain/models/tugas_panitia.dart';
import '../../domain/repositories/agenda_repository.dart';
import '../../domain/repositories/tugas_repository.dart';
import '../../domain/services/hmti_service.dart';

class HomeViewModel extends ChangeNotifier {
  final AgendaRepository _agendaRepo;
  final TugasRepository _tugasRepo;
  final HmtiService _service;

  HomeViewModel(this._agendaRepo, this._tugasRepo, this._service) {
    _tugasRepo.addListener(_onTugasChanged);
  }

  bool isLoading = false;
  bool isOffline = false;
  String? error;
  List<AgendaKegiatan> agendaHariIni = [];
  List<PembayaranIuran> riwayatBayar = [];

  List<TugasPanitia> get tugasBelumSelesai =>
      _tugasRepo.items.where((t) => !t.isSelesai).toList();

  void _onTugasChanged() {
    if (_tugasRepo.lastActionError != null) {
      error = _tugasRepo.lastActionError;
    }
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      isOffline = await _agendaRepo.isOfflineMode();
      final allAgenda = await _agendaRepo.getAgendaList();
      agendaHariIni = allAgenda.where((a) => a.tanggal == 'Hari Ini').toList();
      await _tugasRepo.getTugasList();
      riwayatBayar = await _service.fetchRiwayatPembayaran();

      if (isOffline) {
        error = 'Mode offline aktif: menampilkan data tersimpan lokal.';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleOfflineMode(bool offline) async {
    await _agendaRepo.setOfflineMode(offline);
    await load();
  }

  @override
  void dispose() {
    _tugasRepo.removeListener(_onTugasChanged);
    super.dispose();
  }
}