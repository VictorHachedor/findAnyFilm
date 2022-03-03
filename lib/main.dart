//import 'package:find_any_movie/data/memory_repository.dart';
import 'package:find_any_movie/data/drift/drift_repository.dart';
import 'package:find_any_movie/data/repository.dart';
//import 'package:find_any_movie/data/sqlite/sqlite_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'screens/screens.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  // final repository = SqliteRepository();
  final repository = DriftRepository();
  await repository.init();
  runApp(MyApp(repository: repository));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.repository}) : super(key: key);
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
          lazy: false,
          create: (_) => repository,
          dispose: (_, Repository repository) => repository.close(),
        )
      ],
      child: const MaterialApp(
        title: 'Find Any Movies',
        home: MainScreen(),
      ),
    );
  }
}
