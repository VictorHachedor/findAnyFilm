import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/models/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/app_router.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();
  //TODO add final profile manager
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      //TODO add profileManager
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        // TODO add ChangeNotifierProvider
        ChangeNotifierProvider<MemoryRepository>(
          lazy: false,
          create: (_) => MemoryRepository(),
          )
      ],
      child: MaterialApp(
        title: 'Find Any Movies',
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
