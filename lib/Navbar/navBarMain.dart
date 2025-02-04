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
      width: 80,
      height: MyUtility(context).height,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
         /* Image.asset('images/gmcLogoBig.png'),
          const SizedBox(
            height: 10,
          ),
          Text(
            'v1.1',
            style: TextStyle(
              color: GmcColors().orange,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),*/
          const SizedBox(
            height: 90,
          ),
          NavButtons(
            isActive: activeIndex == 0,
            imageIcon: 'images/homeTab.png',
            onTap: () => _handleItemClick(0),
          ),
          NavButtons(
            isActive: activeIndex == 1,
            imageIcon: 'images/linesTab.png',
            onTap: () => _handleItemClick(1),
          ),
          NavButtons(
            isActive: activeIndex == 2,
            imageIcon: 'images/reportsTab.png',
            onTap: () => _handleItemClick(2),
          ),
          const Spacer(),
          Container(
            height: MyUtility(context).height * 0.50,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/texture.png'),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
