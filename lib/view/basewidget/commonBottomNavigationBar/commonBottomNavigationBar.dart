import 'package:flutter/material.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';
import 'package:shopiana/view/screen/more/more_screen.dart';
import 'package:shopiana/view/screen/order/order_screen.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  final int index;

  CommonBottomNavigationBar({required this.index});

  @override
  State<CommonBottomNavigationBar> createState() =>
      _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  int _selectedIndex = 0;

  BottomNavigationBarItem bottomNavigationBarItem({
    required IconData icon,
    required String lable,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(Icons.local_mall),
      label: lable,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // switch (widget.index) {
      //   case 0:
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => HomePage()));
      //     break;
      //   case 1:
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => OrderScreen()));
      //     break;
      //   case 2:
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => MoreScreen()));
      //     break;
      //   default:
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          bottomNavigationBarItem(icon: Icons.home, lable: "Home"),
          bottomNavigationBarItem(icon: Icons.local_mall, lable: "Orders"),
          bottomNavigationBarItem(icon: Icons.grid_view, lable: "More"),
        ]);
  }
}
