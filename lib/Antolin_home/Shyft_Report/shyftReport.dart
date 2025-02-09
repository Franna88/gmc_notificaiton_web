import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gmcweb/Antolin_home/Shyft_Report/ui/shyftReportTopSection.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:intl/intl.dart';

class ShyftReport extends StatefulWidget {
  const ShyftReport({super.key});

  @override
  _ShyftReportState createState() => _ShyftReportState();
}

class _ShyftReportState extends State<ShyftReport> {
  List<BarChartGroupData> barGroups = [];
  List<String> timeLabels = [];
  double targetValue = 100; // Default target
  int maxEntries = 10; // Number of time intervals visible
  TextEditingController targetController = TextEditingController();
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeChart();
    _startUpdatingChart();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _initializeChart() {
    DateTime now = DateTime.now();
    for (int i = 0; i < maxEntries; i++) {
      timeLabels.add(DateFormat.Hms()
          .format(now.subtract(Duration(seconds: (maxEntries - i) * 15))));
      barGroups.add(_generateBar(0, i));
    }
  }

  void _startUpdatingChart() {
    Timer.periodic(const Duration(seconds: 15), (timer) {
      DateTime now = DateTime.now();
      if (!_isDisposed && mounted) {
        setState(() {
          timeLabels.removeAt(0);
          timeLabels.add(DateFormat.Hms().format(now));

          barGroups.removeAt(0);
          barGroups.add(_generateBar(_getRandomValue(), maxEntries - 1));
        });
      }
    });
  }

  BarChartGroupData _generateBar(double value, int index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: value,
          color: value < targetValue ? Colors.green : Colors.orange,
          width: 50,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  double _getRandomValue() {
    return (50 + (70 * (DateTime.now().second % 5))).clamp(0, 120).toDouble();
  }

  void _updateTargetLine() {
    if (!_isDisposed && mounted) {
      setState(() {
        double newTarget = double.tryParse(targetController.text) ?? 100;
        targetValue = newTarget.clamp(0, 120); // Prevent values outside range
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double chartWidth = MediaQuery.of(context).size.width - 100;
    double chartHeight = MediaQuery.of(context).size.height - 180;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MyUtility(context).height,
        width: MyUtility(context).width,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2, color: GmcColors().antolinBlack),
          ),
        ),
        child: Column(
          children: [
            const ShyftReportTopSection(
                isRunning: true,
                shiftNumber: '1',
                oee: '100%',
                operatorName: 'operatorName',
                workOrder: 'workOrder'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: targetController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter Target Value',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _updateTargetLine,
                    child: const Text('Update Target'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: chartHeight,
              width: chartWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: BarChart(
                      BarChartData(
                        maxY: 120,
                        minY: 0,
                        barGroups: barGroups,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 20,
                              getTitlesWidget: (value, meta) {
                                if (value % 20 == 0 && value <= 120) {
                                  return Text(value.toInt().toString());
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    timeLabels[value.toInt()],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        gridData: const FlGridData(
                            show: true, drawVerticalLine: false),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(color: Colors.grey, width: 1),
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        barTouchData: BarTouchData(enabled: false),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 8),
                    child: SizedBox(
                      width: chartWidth - 120,
                      height: chartHeight - 80,
                      child: CustomPaint(
                        size: Size(chartWidth, chartHeight),
                        painter: DiagonalLinePainter(
                            targetValue, chartHeight, chartWidth),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Painter to draw the diagonal line
class DiagonalLinePainter extends CustomPainter {
  final double targetValue;
  final double chartHeight;
  final double chartWidth;
  final double padding;

  DiagonalLinePainter(this.targetValue, this.chartHeight, this.chartWidth,
      {this.padding = 0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Start position (bottom left)
    double startX = padding;
    double startY = size.height - padding;

    // End position (top right)
    double endX = size.width - padding;

    // Calculate endY based on the target value
    double availableHeight =
        size.height - 2 * padding; // Height available after padding
    double endY = availableHeight -
        ((targetValue / 120) * availableHeight); // Scale target value

    // Ensure that endY stays within the bounds of the chart
    endY = endY.clamp(padding.toDouble(), size.height - padding.toDouble());

    // Draw the line
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
