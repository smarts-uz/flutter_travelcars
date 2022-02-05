import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/profile/profile_screen.dart';
import 'package:travelcars/screens/route/route.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/transfers/transfer.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

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
      Transfer(),
      Routes(),
      ProfileScreen(),
    ];
    final _BottomNavBarItems = <BottomNavigationBarItem>[
       BottomNavigationBarItem(icon: Icon(Icons.home), label: '${LocaleKeys.home.tr()}'),
       BottomNavigationBarItem(icon: Icon(Icons.search), label: '${LocaleKeys.Sort.tr()}'),
       BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/transfer.svg'), label: '${LocaleKeys.transfers.tr()}'),
       BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '${LocaleKeys.itinerary.tr()}'),
       BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: '${LocaleKeys.profile.tr()}'),
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

