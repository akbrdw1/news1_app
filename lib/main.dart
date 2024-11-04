import 'package:flutter/material.dart';
import 'package:news1_app/pages/on_boarding_page.dart';
import 'package:news1_app/providers/news_update_provider.dart';
import 'package:news1_app/providers/news_ekonomi_update_provider.dart';
import 'package:news1_app/providers/news_nasional_update_provider.dart';
import 'package:news1_app/providers/news_tekno_update_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi locale Indonesia
  await intl.initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsUpdateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsTeknoUpdateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsEkonomiUpdateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsNasionalUpdateProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OnBoardingPage(),
      ),
    );
  }
}
