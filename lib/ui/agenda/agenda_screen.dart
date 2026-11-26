import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/repositories/agenda_repository.dart';
import 'agenda_view_model.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  late final AgendaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AgendaViewModel(context.read<AgendaRepository>())..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda HMTI')),
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

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Semua', label: Text('Semua')),
                    ButtonSegment(value: 'Rapat', label: Text('Rapat')),
                    ButtonSegment(value: 'Event', label: Text('Event')),
                    ButtonSegment(value: 'Divisi', label: Text('Divisi')),
                  ],
                  selected: {_viewModel.selectedKategori},
                  onSelectionChanged: (selection) {
                    _viewModel.setKategori(selection.first);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _viewModel.filteredAgenda.length,
                  itemBuilder: (context, index) {
                    final item = _viewModel.filteredAgenda[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF0D47A1),
                        ),
                        title: Text(item.judul),
                        subtitle: Text('${item.tanggal} • ${item.lokasi}'),
                        trailing: Chip(label: Text(item.kategori)),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}