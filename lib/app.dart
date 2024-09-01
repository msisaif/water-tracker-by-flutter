import 'package:flutter/material.dart';
import 'package:water_tracker/home_screen.dart';

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Water Tracker App",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
