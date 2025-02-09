import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateField(context),
          const Text("TO", style: TextStyle(fontSize: 16)),
          _buildDateField(context),
          _buildDropdown("Type", Icons.filter_list),
          _buildDropdown("Shift", Icons.filter_list),
          _buildSearchField(),
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40, // Shorter height
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.calendar_today, size: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4), // Square corners
          ),
        ),
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(String label, IconData icon) {
    return SizedBox(
      width: 200,
      height: 40, // Shorter height
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4), // Square corners
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          suffixIcon: Icon(icon, size: 18), // Filter icon
        ),
        hint: Text(label),
        items: ["Option 1", "Option 2"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 300, // 2.5x longer
      height: 40, // Shorter height
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),
      ),
    );
  }
}
