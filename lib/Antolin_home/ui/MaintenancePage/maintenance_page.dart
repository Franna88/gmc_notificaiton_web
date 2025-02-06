import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/ui/DetailsPage/details_readings.dart';
import 'package:gmcweb/Antolin_home/ui/DetailsPage/press_force_trend_graph.dart';
import 'package:gmcweb/Antolin_home/ui/DetailsPage/stroke_rate_graph.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/maintenance_tabs.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DetailsReadings(), // First section
              SizedBox(height: 50), // Adds space between sections
              MaintenanceTabs(),
            ],
          ),
        ),
      ),
    );
  }
}
