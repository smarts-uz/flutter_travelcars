import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/home_screen.dart';

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
      const Center(child: Icon(Icons.search, size: 64.0, color: Colors.cyan)),
      const Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
      const Center(child: Icon(Icons.map_outlined, size: 64.0, color: Colors.blue)),
      const Center(child: Icon(Icons.person_outline_outlined, size: 64.0, color: Colors.blue)),
    ];
    final _BottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Image.asset('assets/icons/transfer.svg'), label: 'Transfers'),
      const BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Route'),
      const BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
    ];
    assert(_kTabPages.length == _BottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      backgroundColor: Colors.orange,
      selectedItemColor: Colors.white,
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
