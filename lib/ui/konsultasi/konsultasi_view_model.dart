import 'package:flutter/foundation.dart';
import '../../domain/models/informasi_konsultasi.dart';
import '../../domain/repositories/informasi_repository.dart';

class KonsultasiViewModel extends ChangeNotifier {
  final InformasiRepository _repo;
  KonsultasiViewModel(this._repo);

  bool isLoading = false;
  String? error;
  List<InformasiKonsultasi> konsultasiList = [];

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      konsultasiList = await _repo.getKonsultasiList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}