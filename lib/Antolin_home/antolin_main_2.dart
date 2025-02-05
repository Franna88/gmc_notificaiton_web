import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/ui/graphPlaceholders.dart';
import 'package:gmcweb/Antolin_home/ui/homeMetrixContainers.dart';
import 'package:gmcweb/Antolin_home/ui/row_one_grey_containers.dart';
import 'package:gmcweb/Antolin_home/ui/sidePanelFloorPlan.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/myutility.dart';

class AntolinMainTwo extends StatefulWidget {
  const AntolinMainTwo({super.key});

  @override
  State<AntolinMainTwo> createState() => _AntolinMainTwoState();
}

class _AntolinMainTwoState extends State<AntolinMainTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MyUtility(context).height,
        width: MyUtility(context).width,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        child: _buildContainerText('320 000', 'UNITS'),
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
                              alignment: Alignment(
                                  0.03, 0.335), // Positioning slightly down
                              child: FractionallySizedBox(
                                alignment: Alignment.center,
                                widthFactor:
                                    0.08, // Adjust width as a fraction of the parent
                                heightFactor:
                                    0.1, // Adjust height as a fraction of the parent
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    // color: Colors.white, //when offline red
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'images/weight.png', // Path to your image
                                          fit: BoxFit.cover,
                                          width:
                                              MyUtility(context).width * 0.01,
                                          height:
                                              MyUtility(context).height * 0.02,
                                        ),
                                        Text(
                                          'OP 30.2', // Text inside the red container (optional)
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.005, // Scale font size based on screen width
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'PRESS RIGHT', // Text inside the red container (optional)
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.005, // Scale font size based on screen width
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap:
                                              true, // Allow the text to wrap onto multiple lines
                                          overflow: TextOverflow
                                              .visible, // Ensure the text wraps and doesn't overflow
                                        ),
                                      ],
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
