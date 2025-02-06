import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableAttendingProfileContainer extends StatelessWidget {
  final String profileImageUrl = 'images/profile.png';
  final String name;
  final String jobDescription;

  const ReusableAttendingProfileContainer({
    super.key,
    // required this.profileImageUrl,
    required this.name,
    required this.jobDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MyUtility(context).width * 0.15,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                profileImageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 50, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  jobDescription,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
