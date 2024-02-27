import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/features/home/presentation/screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white70,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          unselectedLabelStyle:
              TextStyle(fontSize: Dimensions.fontSizeSmall, color: Colors.grey),
          selectedLabelStyle: TextStyle(
              fontSize: Dimensions.fontSizeSmall, color: Colors.black),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Image.asset('assets/image/home_nav.png',
                      height: 24,
                      color: _selectedIndex == 0 ? Colors.black : Colors.grey)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Image.asset('assets/image/notification_nav.png',
                      height: 24,
                      color: _selectedIndex == 1 ? Colors.black : Colors.grey)),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Image.asset('assets/image/connect_nav.png',
                      height: 24,
                      color: _selectedIndex == 2 ? Colors.black : Colors.grey)),
              label: 'Connect',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Image.asset('assets/image/community_nav.png',
                      height: 24,
                      color: _selectedIndex == 3 ? Colors.black : Colors.grey)),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Image.asset('assets/image/match_nav.png',
                      height: 24,
                      color: _selectedIndex == 4 ? Colors.black : Colors.grey)),
              label: 'Match',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: Image.asset('assets/image/settings_nav.png',
                      height: 24,
                      color: _selectedIndex == 5 ? Colors.black : Colors.grey)),
              label: 'Settings',
            ),
          ],
        ));
  }
}
