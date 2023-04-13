import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/episodios.dart';
import 'package:teleceriado/models/series.dart';
import 'package:teleceriado/screens/feed_series.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Series()),
        ChangeNotifierProvider(create: (context) => Episodios()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(brightness: Brightness.light),
      themeMode: ThemeMode.dark,
      home:
          // AddSerie(),
          const FeedSeries(),
    );
  }
}
