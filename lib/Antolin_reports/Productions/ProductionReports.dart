import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gmcweb/Constants/myutility.dart';

class ProductionRecord {
  final String productType;
  final String batchNumber;
  final int orderQty;
  final int shift;
  final String assignedStaff;
  final int totalOut;
  final int waste;
  final String downtime;

  ProductionRecord({
    required this.productType,
    required this.batchNumber,
    required this.orderQty,
    required this.shift,
    required this.assignedStaff,
    required this.totalOut,
    required this.waste,
    required this.downtime,
  });
}

class ProductionTable extends StatelessWidget {
  final List<ProductionRecord> records;

  const ProductionTable({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    double tableWidth = MyUtility(context).width * 0.95; // 95% of screen width

    return Column(
      children: [
        /// **Table Header (Same Width as Table)**
        Container(
          width: tableWidth,
          color: const Color(0xFF3D3B3C), // Dark Grey Background
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Row(
            children: [
              Expanded(flex: 2, child: TableHeaderText('Product Type')),
              Expanded(flex: 2, child: TableHeaderText('Batch Number')),
              Expanded(flex: 1, child: TableHeaderText('Order Qty')),
              Expanded(flex: 1, child: TableHeaderText('Shift')),
              Expanded(flex: 2, child: TableHeaderText('Assigned Staff')),
              Expanded(flex: 1, child: TableHeaderText('Total Out')),
              Expanded(flex: 1, child: TableHeaderText('Waste')),
              Expanded(flex: 1, child: TableHeaderText('Downtime')),
            ],
          ),
        ),

        /// **Table Body (Same Width as Header, Fully Lined Up)**
        Expanded(
          child: Container(
            width: tableWidth,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                ProductionRecord record = records[index];
                bool isEvenRow = index.isEven;

                return Container(
                  color: isEvenRow
                      ? Colors.white
                      : const Color(0xFFD9D9D9), // Alternate row colors
                  padding: const EdgeInsets.symmetric(
                      vertical: 8), // Padding to match header height
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: TableText(record.productType)),
                      Expanded(flex: 2, child: TableText(record.batchNumber)),
                      Expanded(
                          flex: 1,
                          child: FixedSizeCell(record.orderQty.toString())),
                      Expanded(
                          flex: 1, child: TableText(record.shift.toString())),
                      Expanded(flex: 2, child: TableText(record.assignedStaff)),
                      Expanded(
                          flex: 1,
                          child: FixedSizeCell(record.totalOut.toString())),
                      Expanded(
                          flex: 1, child: TableText(record.waste.toString())),
                      Expanded(flex: 1, child: FixedSizeCell(record.downtime)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// **Table Header Styling (Lined Up with Table)**
class TableHeaderText extends StatelessWidget {
  final String text;
  const TableHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// **Styled Table Text (Aligned with Header)**
class TableText extends StatelessWidget {
  final String text;
  const TableText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// **Fixed-Size Data Cells (Ensuring Consistency for Numbers)**
class FixedSizeCell extends StatelessWidget {
  final String text;
  const FixedSizeCell(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90, // Fixed width for consistency
      height: 35, // Fixed height for consistency
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
