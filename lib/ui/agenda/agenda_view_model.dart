import 'package:flutter/foundation.dart';
import '../../domain/models/agenda_kegiatan.dart';
import '../../domain/repositories/agenda_repository.dart';

class AgendaViewModel extends ChangeNotifier {
  final AgendaRepository _repo;
  AgendaViewModel(this._repo);

  bool isLoading = false;
  String? error;
  List<AgendaKegiatan> _allAgenda = [];
  String selectedKategori = 'Semua';

  List<AgendaKegiatan> get filteredAgenda {
    if (selectedKategori == 'Semua') return _allAgenda;
    return _allAgenda.where((a) => a.kategori == selectedKategori).toList();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _allAgenda = await _repo.getAgendaList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setKategori(String kategori) {
    selectedKategori = kategori;
    notifyListeners();
  }
}