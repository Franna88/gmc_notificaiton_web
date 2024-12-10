import 'dart:html' as html;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/lineStatus.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/userIconContainer.dart';
import 'package:google_fonts/google_fonts.dart';

class LineContainer extends StatefulWidget {
  final String lineID;

  const LineContainer({super.key, required this.lineID});

  @override
  State<LineContainer> createState() => _LineContainerState();
}

class _LineContainerState extends State<LineContainer> {
  Future<void> _uploadDocument() async {
    // Create a file input element for web
    final html.FileUploadInputElement uploadInput =
        html.FileUploadInputElement();
    uploadInput.accept = '.pdf,.doc,.docx'; // Restrict to certain file types
    uploadInput.click(); // Trigger file picker

    uploadInput.onChange.listen((event) async {
      final file = uploadInput.files?.first;

      if (file != null) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((event) async {
          try {
            // Convert file to Uint8List
            final Uint8List fileBytes = reader.result as Uint8List;
            final String fileName = file.name;

            // Log debug messages
            print("File selected: $fileName");
            print("File size: ${fileBytes.length} bytes");

            // Upload file to Firebase Storage
            final Reference storageReference = FirebaseStorage.instance.ref(
                'lineDocs/${widget.lineID}/${DateTime.now().millisecondsSinceEpoch}_$fileName');

            final UploadTask uploadTask = storageReference.putData(
              fileBytes,
              SettableMetadata(contentType: file.type),
            );

            // Await upload completion
            final TaskSnapshot snapshot = await uploadTask;
            print(
                "File uploaded successfully: ${snapshot.bytesTransferred} bytes");

            // Get the download URL of the uploaded file
            final String downloadURL = await snapshot.ref.getDownloadURL();
            print("Download URL: $downloadURL");

            // Save the download URL to Firestore
            await FirebaseFirestore.instance
                .collection('systems')
                .doc(widget.lineID)
                .set({
              'documents': FieldValue.arrayUnion([
                {'downloadUrl': downloadURL, 'fileName': fileName}
              ]),
            }, SetOptions(merge: true));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Document uploaded successfully!')),
            );
          } catch (e) {
            print("Error during file upload: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error uploading document: $e')),
            );
          }
        });
      } else {
        print("No file selected.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('systems')
          .doc(widget.lineID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final isOffline = !(data['online'] as bool);
        final technicianName = data['technicianName'] ?? 'No Technician';
        final lineName = data['line_Name'] ?? 'No Name';

        return Container(
          height: 80,
          width: MyUtility(context).width - 80,
          decoration: BoxDecoration(
            color: GmcColors().lightGrey,
            border: Border.all(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Line Name
                Text(
                  lineName,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),

                // Add Drawing Button
                ElevatedButton(
                  onPressed: _uploadDocument,
                  child: Text('Add Drawing'),
                ),

                // User Icon Container
                Visibility(
                  visible: isOffline,
                  child: UserIconContainer(
                    userName: technicianName,
                  ),
                ),
                const SizedBox(width: 30),

                // Line Status
                LineStatus(isOffline: isOffline),
              ],
            ),
          ),
        );
      },
    );
  }
}
