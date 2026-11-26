import 'package:flutter/foundation.dart';
import '../../domain/models/tugas_panitia.dart';
import '../../domain/repositories/tugas_repository.dart';

class ChecklistViewModel extends ChangeNotifier {
  final TugasRepository _repo;

  ChecklistViewModel(this._repo) {
    _repo.addListener(notifyListeners);
  }

  bool isLoading = false;
  String? error;

  List<TugasPanitia> get belumSelesai =>
      _repo.items.where((t) => !t.isSelesai).toList();
  List<TugasPanitia> get selesai =>
      _repo.items.where((t) => t.isSelesai).toList();

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _repo.getTugasList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTugas(String id) async {
    error = null;
    notifyListeners();
    try {
      await _repo.toggleStatus(id);
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _repo.removeListener(notifyListeners);
    super.dispose();
  }
}