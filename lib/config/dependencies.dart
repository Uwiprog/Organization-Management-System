import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../domain/repositories/agenda_repository.dart';
import '../domain/repositories/informasi_repository.dart';
import '../domain/repositories/tugas_repository.dart';
import '../domain/services/hmti_service.dart';

List<SingleChildWidget> get globalProviders => [
      Provider<HmtiService>(create: (_) => HmtiService()),
      ProxyProvider<HmtiService, AgendaRepository>(
        update: (_, service, _) => AgendaRepository(service),
      ),
      ChangeNotifierProxyProvider<HmtiService, TugasRepository>(
        create: (context) => TugasRepository(context.read<HmtiService>()),
        update: (_, service, previous) => previous ?? TugasRepository(service),
      ),
      ProxyProvider<HmtiService, InformasiRepository>(
        update: (_, service, _) => InformasiRepository(service),
      ),
    ];