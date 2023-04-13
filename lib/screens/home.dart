import 'package:flutter/material.dart';
import 'package:teleceriado/screens/feed_series.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    const FeedSeries(),
  ];

  int _currentPage = 0;
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('home'),),
      body: Container(
        color: Colors.blue,
        height: height*0.5,
        width: width*0.9,
      ),
    );
  }
}