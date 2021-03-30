
import 'package:flutter/material.dart';
import 'package:wisatapandeglang/page/home.dart';
import 'package:wisatapandeglang/page/list.dart';
import 'package:wisatapandeglang/page/profile.dart';



class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.wallet_travel_sharp, 1),

          buildNavBarItem(Icons.person, 2),
        ],
      ),

      body: Center(
        child: _selectedItemIndex==0?home():_selectedItemIndex==1?wisata(): Profile(),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 3,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4, color: Colors.blue),
            ),
            gradient: LinearGradient(colors: [
              Colors.blueAccent.withOpacity(0.3),
              Colors.blueAccent.withOpacity(0.015),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
          // color: index == _selectedItemIndex ? Colors.green : Colors.white,
        )
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}