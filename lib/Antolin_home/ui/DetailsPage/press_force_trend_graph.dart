import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class PressForceTrendGraph extends StatelessWidget {
  const PressForceTrendGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    final List<int> lastSixYears =
        List.generate(6, (index) => currentYear - (5 - index));

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              color: GmcColors().antolinBlack,
              height: MyUtility(context).height * 0.05,
              width: MyUtility(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Press Force Trend',
                      style: GoogleFonts.poppins(
                        color: GmcColors().antolinOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MyUtility(context).height * 0.8,
            width: MyUtility(context).width * 0.9,
            child: Container(
              decoration: BoxDecoration(
                color: GmcColors().antolinBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatusIndicator(
                            Colors.green, 'Within Safe Range'),
                        const SizedBox(width: 20),
                        _buildStatusIndicator(Colors.red, 'Overload'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        backgroundColor: GmcColors().antolinBlack,
                        gridData: FlGridData(
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.white.withOpacity(0.3),
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 200,
                              getTitlesWidget: (value, _) {
                                return Text(
                                  value.toInt().toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              interval: 1,
                              getTitlesWidget: (value, _) {
                                if (value >= 0 && value < 6) {
                                  return Text(
                                    lastSixYears[value.toInt()].toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 800),
                              const FlSpot(1, 1100),
                              const FlSpot(2, 950),
                              const FlSpot(3, 1200),
                              const FlSpot(4, 1400),
                              const FlSpot(5, 600),
                            ],
                            isCurved: false,
                            barWidth: 3,
                            color: Colors.greenAccent,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.greenAccent.withOpacity(0.3),
                            ),
                            dotData: FlDotData(show: false),
                          ),
                        ],
                        minX: 0,
                        maxX: 5,
                        minY: 0,
                        maxY: 1600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
