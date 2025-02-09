import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsReusableContainer extends StatelessWidget {
  final String icon;
  final String text;
  final String amount;
  final String? calculationOne;

  const DetailsReusableContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.amount,
    this.calculationOne,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: MyUtility(context).height * 0.04,
          width: MyUtility(context).height * 0.04,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          width: MyUtility(context).width * 0.04,
          height: MyUtility(context).height * 0.05,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              amount,
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (calculationOne !=
            null) // Only shows this if calculationOne is not null
          Container(
            width: MyUtility(context).width * 0.03,
            height: MyUtility(context).height * 0.05,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                calculationOne!,
                style: GoogleFonts.inter(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
