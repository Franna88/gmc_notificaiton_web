import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';

import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Navbar/ui/navButtons.dart';

class NavBarMain extends StatefulWidget {
  final int initialIndex;
  final Function(int) onTabSelected;

  const NavBarMain({
    super.key,
    required this.initialIndex,
    required this.onTabSelected,
  });

  @override
  State<NavBarMain> createState() => _NavBarMainState();
}

class _NavBarMainState extends State<NavBarMain> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _handleItemClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: MyUtility(context).height,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const SizedBox(height: 90),
          NavButtons(
            imageIcon: 'images/homeTab.png',
            onTap: () => _handleItemClick(0),
            isActive: _selectedIndex ==
                0, // Pass isActive based on the selected index
          ),
          NavButtons(
            imageIcon: 'images/linesTab.png',
            onTap: () => _handleItemClick(1),
            isActive: _selectedIndex ==
                1, // Pass isActive based on the selected index
          ),
          NavButtons(
            imageIcon: 'images/reportsTab.png',
            onTap: () => _handleItemClick(2),
            isActive: _selectedIndex ==
                2, // Pass isActive based on the selected index
          ),
          const Spacer(),
          Container(
            height: MyUtility(context).height * 0.50,
            width: 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/texture.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
