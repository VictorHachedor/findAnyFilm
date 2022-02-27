import 'package:find_any_movie/data/memory_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'screens/screens.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [    
        ChangeNotifierProvider<MemoryRepository>(
          lazy: false,
          create: (_) => MemoryRepository(),
          )
      ],
      child: const MaterialApp(
        title: 'Find Any Movies',
        home: MainScreen(),
      ),
    );
  }
}