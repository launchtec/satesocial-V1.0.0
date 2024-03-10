import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/core/util/styles.dart';
import 'package:sate_social/features/community/presentation/screens/community_screen.dart';
import 'package:sate_social/features/home/presentation/screens/home_screen.dart';
import 'package:sate_social/features/notifications/presentation/screens/notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> widgetOptions(PageController navController) {
   return <Widget>[
     HomeScreen(navController: _pageController),
     const NotificationScreen(),
     Container(),
     const CommunityScreen(),
     Container(),
     Container(),
   ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: widgetOptions(_pageController),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(index);
            });
          },
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
                  padding: EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Image.asset('assets/image/home_nav.png',
                      height: 24,
                      color: _selectedIndex == 0 ? ColorConstants.primaryColor : Colors.grey)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Image.asset('assets/image/notification_nav.png',
                      height: 24,
                      color: _selectedIndex == 1 ? ColorConstants.primaryColor : Colors.grey)),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Image.asset('assets/image/connect_nav.png',
                      height: 24,
                      color: _selectedIndex == 2 ? ColorConstants.primaryColor : Colors.grey)),
              label: 'Connect',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Image.asset('assets/image/community_nav.png',
                      height: 24,
                      color: _selectedIndex == 3 ? ColorConstants.primaryColor : Colors.grey)),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Image.asset('assets/image/match_nav.png',
                      height: 24,
                      color: _selectedIndex == 4 ? ColorConstants.primaryColor : Colors.grey)),
              label: 'Match',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                  child: Image.asset('assets/image/settings_nav.png',
                      height: 24,
                      color: _selectedIndex == 5 ? ColorConstants.primaryColor : Colors.grey)),
              label: 'Settings',
            ),
          ],
        ));
  }
}
