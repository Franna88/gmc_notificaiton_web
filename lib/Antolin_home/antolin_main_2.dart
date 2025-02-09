import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/lineMachineListPopup.dart';
import 'package:gmcweb/Antolin_home/ui/graphPlaceholders.dart';
import 'package:gmcweb/Antolin_home/ui/homeMetrixContainers.dart';
import 'package:gmcweb/Antolin_home/ui/row_one_grey_containers.dart';
import 'package:gmcweb/Antolin_home/ui/sidePanelFloorPlan.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Constants/myutility.dart';

class AntolinMainTwo extends StatefulWidget {
  final Function(int, Widget) navigateToPage;
  const AntolinMainTwo({super.key, required this.navigateToPage});

  @override
  State<AntolinMainTwo> createState() => _AntolinMainTwoState();
}

class _AntolinMainTwoState extends State<AntolinMainTwo> {
  // Add this function outside build
  Future<void> _showOrderQtyDialog() async {
    final TextEditingController orderQtyController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Order Quantity'),
        content: TextField(
          controller: orderQtyController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter quantity in units',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final qty = orderQtyController.text;
              await FirebaseFirestore.instance.collection('orders').add({
                'quantity': qty,
                'timestamp': FieldValue.serverTimestamp(),
              });
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
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
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('orders')
                                .orderBy('timestamp', descending: true)
                                .limit(1)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty) {
                                final latestOrder = snapshot.data!.docs.first
                                    .data() as Map<String, dynamic>;
                                return _buildContainerText(
                                    latestOrder['quantity'].toString(),
                                    'UNITS');
                              }
                              return _buildContainerText('0', 'UNITS');
                            },
                          ),
                        ),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Total Out',
                        child: _buildContainerText('280 000', 'UNITS'),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Total Waste',
                        child: _buildContainerText('15 000', 'UNITS'),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Batch Number',
                        child: _buildContainerText('BATCH 47A', ''),
                      ),
                    ),
                    RowOneGreyContainers(
                      contents: HomeMetrixContainers(
                        header: 'Target',
                        child: _buildContainerText('350 000', 'UNITS'),
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
                                                : Colors.red,
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
