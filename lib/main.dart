import 'package:flutter/material.dart';
import 'package:radius_task_jwst_api/pages/infinite_scroll.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfiniteScrollPage(),
    );
  }
}
