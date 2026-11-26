import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/repositories/informasi_repository.dart';
import 'konsultasi_view_model.dart';

class KonsultasiScreen extends StatefulWidget {
  const KonsultasiScreen({super.key});

  @override
  State<KonsultasiScreen> createState() => _KonsultasiScreenState();
}

class _KonsultasiScreenState extends State<KonsultasiScreen> {
  late final KonsultasiViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = KonsultasiViewModel(context.read<InformasiRepository>())
      ..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Konsultasi HMTI')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_viewModel.error!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _viewModel.load,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _viewModel.konsultasiList.length,
            itemBuilder: (context, index) {
              final item = _viewModel.konsultasiList[index];
              final isApproved =
                  item.status == 'Disetujui' || item.status == 'Selesai';
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  leading: const Icon(
                    Icons.support_agent,
                    color: Color(0xFF0D47A1),
                  ),
                  title: Text(item.topik),
                  subtitle: Text('${item.namaDosen} • ${item.jadwal}'),
                  trailing: Chip(
                    label: Text(item.status),
                    backgroundColor: isApproved
                        ? Colors.green.shade100
                        : Colors.amber.shade100,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}