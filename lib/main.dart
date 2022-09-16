import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/home/home_screen.dart';
import 'package:db_sample/provders/provider_imagepic.dart';
import 'package:db_sample/provders/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbFunctions().createDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImagePicProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DbFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
