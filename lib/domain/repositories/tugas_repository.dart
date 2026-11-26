import 'package:flutter/foundation.dart';
import '../models/tugas_panitia.dart';
import '../services/hmti_service.dart';

class TugasRepository extends ChangeNotifier {
  final HmtiService _service;
  List<TugasPanitia> _items = [];
  bool _isInitialized = false;
  String? lastActionError;

  TugasRepository(this._service);

  List<TugasPanitia> get items => List.unmodifiable(_items);

  Future<List<TugasPanitia>> getTugasList() async {
    final fetched = await _service.fetchTugas();
    _items = fetched;
    _isInitialized = true;
    lastActionError = null;
    notifyListeners();
    return _items;
  }

  Future<void> toggleStatus(String id) async {
    try {
      if (!_isInitialized && _items.isEmpty) {
        _items = await _service.fetchTugas();
        _isInitialized = true;
      }

      final index = _items.indexWhere((item) => item.id == id);
      if (index == -1) {
        throw Exception('Item tugas tidak ditemukan.');
      }

      _items[index] = _items[index].copyWith(isSelesai: !_items[index].isSelesai);
      await _service.saveTugas(_items);
      lastActionError = null;
      notifyListeners();
    } catch (e) {
      lastActionError = 'Gagal menyimpan perubahan checklist: $e';
      notifyListeners();
      rethrow;
    }
  }
}