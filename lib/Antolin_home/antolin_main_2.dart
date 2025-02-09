import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/lineMachineListPopup.dart';
import 'package:gmcweb/Antolin_home/ui/graphPlaceholders.dart';
import 'package:gmcweb/Antolin_home/ui/homeMetrixContainers.dart';
import 'package:gmcweb/Antolin_home/ui/row_one_grey_containers.dart';
import 'package:gmcweb/Antolin_home/ui/sidePanelFloorPlan.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../Constants/myutility.dart';

class AntolinMainTwo extends StatefulWidget {
  final Function(int, Widget) navigateToPage;
  const AntolinMainTwo({super.key, required this.navigateToPage});

  @override
  State<AntolinMainTwo> createState() => _AntolinMainTwoState();
}

class _AntolinMainTwoState extends State<AntolinMainTwo> {
  StreamSubscription? _systemCountSubscription;
  Timer? _flickerTimer;
  bool _showRed = false;
  StreamSubscription? _shyftProdSubscription;
  StreamSubscription? _downtimeSubscription;

  // Add these as class variables
  bool _isCurrentlyOffline = false;
  String? _currentDowntimeId;

  @override
  void initState() {
    super.initState();
    _listenToSystemCount();
    _listenToDowntime();
    _listenToShyftProd();
    _flickerTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (mounted) {
        setState(() {
          _showRed = !_showRed;
        });
      }
    });
  }

  @override
  void dispose() {
    _systemCountSubscription?.cancel();
    _shyftProdSubscription?.cancel();
    _downtimeSubscription?.cancel();
    _flickerTimer?.cancel();
    super.dispose();
  }

  void _listenToDowntime() {
    _downtimeSubscription = FirebaseFirestore.instance
        .collection('systems')
        .doc('7uiqZnLD4iu5wRLzabpe')
        .snapshots()
        .listen((snapshot) async {
      try {
        if (!snapshot.exists) return;

        final bool isOnline = snapshot.data()?['online'] ?? true;
        final String lineId = snapshot.id; // Use document ID as lineId

        // Check if there's already an unresolved record before creating new one
        if (!isOnline && !_isCurrentlyOffline) {
          // Check for existing unresolved records
          final existingQuery = await FirebaseFirestore.instance
              .collection('downtime')
              .where('lineId', isEqualTo: lineId)
              .where('resolved', isEqualTo: false)
              .get();

          // Only create new record if no unresolved records exist
          if (existingQuery.docs.isEmpty) {
            _isCurrentlyOffline = true;
            final docRef =
                await FirebaseFirestore.instance.collection('downtime').add({
              'lineId': lineId,
              'startTime': FieldValue.serverTimestamp(),
              'endTime': null,
              'duration': 0,
              'user': 'unknown',
              'resolved': false,
              'reason': '',
              'actions': '',
              'comments': ''
            });
            _currentDowntimeId = docRef.id;
          }
        }
        // Going online - update existing record
        else if (isOnline &&
            _isCurrentlyOffline &&
            _currentDowntimeId != null) {
          final downtimeDoc = await FirebaseFirestore.instance
              .collection('downtime')
              .doc(_currentDowntimeId)
              .get();

          if (downtimeDoc.exists) {
            final startTime =
                (downtimeDoc.data()?['startTime'] as Timestamp).toDate();
            final endTime = DateTime.now();
            final duration = endTime.difference(startTime).inMinutes;

            await downtimeDoc.reference.update({
              'endTime': FieldValue.serverTimestamp(),
              'duration': duration,
              'resolved': true
            });
          }

          // Reset tracking variables
          _isCurrentlyOffline = false;
          _currentDowntimeId = null;
        }
      } catch (e) {
        print('Downtime Error: $e');
        _isCurrentlyOffline = false;
        _currentDowntimeId = null;
      }
    });
  }

  void _listenToShyftProd() {
    _shyftProdSubscription = FirebaseFirestore.instance
        .collection('systems')
        .doc('7uiqZnLD4iu5wRLzabpe')
        .snapshots()
        .listen((snapshot) async {
      if (!snapshot.exists) return;

      // Get count from systems
      final String countString = snapshot.data()?['count']?.toString() ?? '0';
      final int count = int.parse(countString);

      // Get current user
      final userDoc = await FirebaseFirestore.instance
          .collection('currentUser')
          .doc('activeUser')
          .get();

      final String currentUser = userDoc.data()?['email'] ?? 'unknown';

      // Create new shyftProd record
      await FirebaseFirestore.instance.collection('shyftProd').add({
        'lineId': '7uiqZnLD4iu5wRLzabpe',
        'date': DateTime.now(),
        'user': currentUser,
        'count': count
      });
    });
  }

  void _listenToSystemCount() {
    try {
      _systemCountSubscription = FirebaseFirestore.instance
          .collection('systems')
          .doc('7uiqZnLD4iu5wRLzabpe')
          .snapshots()
          .listen((snapshot) async {
        if (!snapshot.exists) return;

        // Convert count to integer
        final String countString = snapshot.data()?['count']?.toString() ?? '0';
        final int count = int.parse(countString);

        // Get the latest production document
        final productionQuery = await FirebaseFirestore.instance
            .collection('production')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        if (productionQuery.docs.isNotEmpty) {
          final latestProductionDoc = productionQuery.docs.first;
          final productionData = latestProductionDoc.data();
          final orderQty = productionData['orderQuantity'] as num? ?? 0;

          // Calculate percentage
          int percentage = 0;
          if (orderQty > 0) {
            percentage = ((count / orderQty) * 100).round();
          }

          // Update both totalOut and target
          await latestProductionDoc.reference.update({
            'totalOut': count,
            'target': percentage,
          });
        }
      });
    } catch (e) {
      print('Firestore Error: $e');
    }
  }

  // Add this function outside build
  Future<void> _showOrderQtyDialog() async {
    final TextEditingController orderQtyController = TextEditingController();
    final TextEditingController batchController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Production Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: orderQtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter quantity in units',
                labelText: 'Order Quantity',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: batchController,
              decoration: const InputDecoration(
                hintText: 'Enter batch number',
                labelText: 'Batch Number',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('production').add({
                'orderQuantity': int.tryParse(orderQtyController.text) ?? 0,
                'totalOut': 0,
                'totalWaste': 0,
                'batchNumber':
                    batchController.text, // Keep as string for batch numbers
                'target': 0,
                'timestamp': FieldValue.serverTimestamp(),
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // First, create a reusable StreamBuilder function
  Widget _buildProductionStreamContainer(String field, String unit) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('production')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildContainerText('0', unit);
        }

        final latestData =
            snapshot.data!.docs.first.data() as Map<String, dynamic>;
        String displayValue;

        if (field == 'batchNumber') {
          displayValue = latestData[field]?.toString() ?? 'N/A';
        } else {
          // Handle numeric fields
          final value = latestData[field];
          displayValue = (value is num) ? value.toString() : '0';
        }

        return _buildContainerText(displayValue, unit);
      },
    );
  }

  // Calculate and display percentage completion
  Widget _buildCompletionPercentage() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('production')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildContainerText('0', '%');
        }

        final latestData =
            snapshot.data!.docs.first.data() as Map<String, dynamic>;
        final orderQty = latestData['orderQuantity'] as num? ?? 0;
        final totalOut = latestData['totalOut'] as num? ?? 0;

        // Calculate percentage
        int percentage = 0;
        if (orderQty > 0) {
          percentage = ((totalOut / orderQty) * 100).round();
        }

        // Update target field in Firestore
        FirebaseFirestore.instance
            .collection('production')
            .doc(snapshot.data!.docs.first.id)
            .update({'target': percentage});

        return _buildContainerText(percentage.toString(), '%');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(color: GmcColors().antolinBlack, width: 3))),
        height: MyUtility(context).height,
        width: MyUtility(context).width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 55,
                width: MyUtility(context).width - 80,
                color: GmcColors().antolinBlack,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 3),
                      child: Container(
                        height: 44,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              GmcColors().antolinTeal,
                              const Color.fromRGBO(16, 90, 71, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'SIDE PANELS',
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // First Section: AspectRatio for Row with 5 Containers
              AspectRatio(
                aspectRatio: 4 /
                    0.36, // Adjusted ratio for 5 containers (slightly taller)
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Even spacing between containers
                  children: [
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Order Qty',
                        child: GestureDetector(
                          onTap: _showOrderQtyDialog,
                          child: _buildProductionStreamContainer(
                              'orderQuantity', 'UNITS'),
                        ),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Total Out',
                        child: _buildProductionStreamContainer(
                            'totalOut', 'UNITS'),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Total Waste',
                        child: _buildProductionStreamContainer(
                            'totalWaste', 'UNITS'),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Batch Number',
                        child: _buildProductionStreamContainer(
                            'batchNumber', 'BATCH'),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Target',
                        child: _buildProductionStreamContainer('target', '%'),
                      ),
                    ),
                  ],
                ),
              ),
              // Second Section: Row with Column and Right Container
              AspectRatio(
                aspectRatio: 3 /
                    1.3, // Adjusted ratio for left column (2 containers) vs right container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Even spacing between left column and right container
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // Stretch the column containers to fill available space
                  children: [
                    // Left Column with 2 Containers
                    AspectRatio(
                      aspectRatio: 1 / 2.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: RowOneGreyContainers(
                              contents: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          20), // Optional padding for spacing
                                      child: Image.asset(
                                        'images/total_downtime.png',
                                        fit: BoxFit
                                            .cover, // Ensures the full image fits inside
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RowOneGreyContainers(
                              contents: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Image.asset(
                                        'images/progress.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right Container
                    AspectRatio(
                      aspectRatio:
                          2.37 / 1.29, // Adjusted ratio for the right container
                      child: RowOneGreyContainers(
                        contents: Stack(
                          alignment: Alignment
                              .center, // Center the image and the red container
                          children: [
                            // Image at the bottom
                            Image.asset(
                              'images/layout_tab_two.png', // Path to your image
                              fit: BoxFit.cover,
                            ),
                            // Red container positioned slightly down in the middle
                            Align(
                              alignment: const Alignment(
                                  0.03, 0.335), // Positioning slightly down
                              child: FractionallySizedBox(
                                alignment: Alignment.center,
                                widthFactor:
                                    0.08, // Adjust width as a fraction of the parent
                                heightFactor:
                                    0.1, // Adjust height as a fraction of the parent
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor:
                                              const Color.fromARGB(0, 0, 0, 0),
                                          child: Container(
                                            padding: const EdgeInsets.all(20),

                                            child: LineMachineListPopup(
                                                navigateToPage: widget
                                                    .navigateToPage), // Use correct function
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('systems')
                                          .doc('7uiqZnLD4iu5wRLzabpe')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const CircularProgressIndicator();
                                        }

                                        final isOnline =
                                            snapshot.data?['online'] ?? false;

                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: isOnline
                                                ? Colors.white
                                                : (_showRed
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                  'images/weight.png',
                                                  fit: BoxFit.cover,
                                                  width:
                                                      MyUtility(context).width *
                                                          0.01,
                                                  height: MyUtility(context)
                                                          .height *
                                                      0.02,
                                                ),
                                                Text(
                                                  'OP 30.2',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.006,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Text(
                                                  'PRESS RIGHT',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.006,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerText(String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: GmcColors().antolinTeal,
            fontSize: 19,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        Text(
          unit,
          style: GoogleFonts.inter(
            letterSpacing: 1.4,
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ],
    );
  }
}
