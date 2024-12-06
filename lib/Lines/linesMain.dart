import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/CommonUi/stackedHeaders.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/ui/LineContainers/lineContainer.dart';
import 'package:gmcweb/Lines/ui/newLinePopup.dart';

class LinesMain extends StatefulWidget {
  const LinesMain({super.key});

  @override
  State<LinesMain> createState() => _LinesMainState();
}

class _LinesMainState extends State<LinesMain> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<LineContainer> lineContainers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLinesData();
  }

  Future<void> fetchLinesData() async {
    try {
      final querySnapshot = await _firestore.collection('systems').get();
      print('Fetched ${querySnapshot.docs.length} lines');

      for (var doc in querySnapshot.docs) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      }

      final lines = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return LineContainer(
          isOffline: !(data['online'] as bool),
          lineID: doc.id,
        );
      }).toList();

      setState(() {
        lineContainers = lines;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addNewLine(String lineID) async {
    try {
      // Add a new document to Firestore (optional)
      await _firestore.collection('systems').doc(lineID).set({
        'online': false,
        'isAlreadyDown': false,
        'attending': false,
        'isUpdating': false,
        'line_Name': lineID,
      });

      // Fetch the latest data
      await fetchLinesData();
    } catch (e) {
      print('Error adding new line: $e');
    }
  }

  Future openNewLinePopup() => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: NewLinePopup(
              onAddLine: addNewLine,
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SizedBox(
            width: MyUtility(context).width - 280,
            height: MyUtility(context).height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  StackedHeaders(
                    constrianedWidth: 450,
                    width: 445,
                    header: 'Lines',
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SmallButtons(
                      onTap: openNewLinePopup,
                      buttonText: 'Add Line',
                      buttonColor: GmcColors().teal,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: MyUtility(context).width - 360,
                    height: 50,
                    color: GmcColors().black,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 50),
                      child: Row(
                        children: [
                          Text(
                            'Line ID',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Status',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: lineContainers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: lineContainers[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
