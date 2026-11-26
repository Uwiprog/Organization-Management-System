import 'package:flutter_test/flutter_test.dart';
import 'package:hmti_management_system_v2/domain/models/informasi_konsultasi.dart';
import 'package:hmti_management_system_v2/domain/repositories/informasi_repository.dart';
import 'package:hmti_management_system_v2/ui/konsultasi/konsultasi_view_model.dart';

class FakeInformasiRepository implements InformasiRepository {
  @override
  Future<List<InformasiKonsultasi>> getKonsultasiList() async {
    return const [
      InformasiKonsultasi(
        id: '1',
        namaDosen: 'Pembina HMTI',
        topik: 'Persetujuan Proposal',
        jadwal: 'Kamis',
        status: 'Disetujui',
      ),
    ];
  }
}

void main() {
  test('KonsultasiViewModel load() mengisi daftar konsultasi', () async {
    final vm = KonsultasiViewModel(FakeInformasiRepository());
    expect(vm.isLoading, false);
    expect(vm.konsultasiList.isEmpty, true);

    await vm.load();

    expect(vm.isLoading, false);
    expect(vm.error, isNull);
    expect(vm.konsultasiList.length, 1);
    expect(vm.konsultasiList.first.topik, 'Persetujuan Proposal');
  });
}