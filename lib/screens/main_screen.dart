import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/transfers/transfers_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = [
      HomeScreen(),
      SearchScreen(),
      TransfersScreen(),
      const Center(child: Icon(Icons.map_outlined, size: 64.0, color: Colors.blue)),
      const Center(child: Icon(Icons.person_outline_outlined, size: 64.0, color: Colors.blue)),
    ];
    final _BottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/transfer.svg'), label: 'Transfers'),
      const BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Route'),
      const BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
    ];
    assert(_kTabPages.length == _BottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      backgroundColor: Color.fromRGBO(239, 127, 26, 1),
      selectedItemColor: Colors.white,
      selectedFontSize: 17,
      unselectedFontSize: 15,
      iconSize: 25,
      unselectedItemColor: Colors.white70,
      items: _BottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}

