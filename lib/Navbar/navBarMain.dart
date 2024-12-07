import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Navbar/ui/navButtons.dart';
import 'package:gmcweb/Constants/myutility.dart';

class NavBarMain extends StatefulWidget {
  final Function(int) changePage;

  const NavBarMain({
    super.key,
    required this.changePage,
  });

  @override
  State<NavBarMain> createState() => _NavBarMainState();
}

class _NavBarMainState extends State<NavBarMain> {
  int activeIndex = 0;

  void _handleItemClick(int index) {
    setState(() {
      activeIndex = index;
    });
    widget.changePage(index); // Notify the parent widget to change the page
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: MyUtility(context).height,
      color: GmcColors().black,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset('images/gmcLogoBig.png'),
          const SizedBox(
            height: 10,
          ),
          Text(
            'v1.0',
            style: TextStyle(
              color: GmcColors().orange,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          NavButtons(
            isActive: activeIndex == 0,
            buttonText: 'LINES',
            onTap: () => _handleItemClick(0),
          ),
          NavButtons(
            isActive: activeIndex == 1,
            buttonText: 'USERS',
            onTap: () => _handleItemClick(1),
          ),
          NavButtons(
            isActive: activeIndex == 2,
            buttonText: 'REPORTS',
            onTap: () => _handleItemClick(2),
          ),
          const Spacer(),
          Container(
            height: 200,
            width: 280,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/stripes.png'),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
