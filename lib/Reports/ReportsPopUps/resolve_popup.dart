import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:image_network/image_network.dart';

class ResolvePopup extends StatelessWidget {
  final Map<String, dynamic> resolutionData;

  const ResolvePopup({Key? key, required this.resolutionData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: MyUtility(context).height * 0.8,
          width: MyUtility(context).width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Header Section
              Container(
                decoration: BoxDecoration(
                  color: GmcColors().black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: MyUtility(context).width * 0.4,
                height: MyUtility(context).height * 0.07,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          'RESOLVED',
                          style: TextStyle(
                            color: GmcColors().orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),

              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How was the issue resolved:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        resolutionData['description'] ??
                            'No resolution details available.',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Image:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: MyUtility(context).height * 0.35,
                        width: MyUtility(context).width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: resolutionData['imageUrl'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: ImageNetwork(
                                  image: resolutionData['imageUrl'],
                                  width: 500,
                                  height: 500,
                                  fitWeb: BoxFitWeb.cover,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'No image available.',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                  ),
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
      ),
    );
  }
}
