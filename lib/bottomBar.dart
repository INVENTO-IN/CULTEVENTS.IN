import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cult_events/Screens/events-3rd/events.dart';
import 'package:cult_events/Screens/profile-4th/profile.dart';
import 'package:cult_events/service/network_service.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Screens/HomeScreen 1st/homeScreen.dart';
import 'Screens/ideas-2rd/ideas.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    IdeasScreen(),
    EventsScreen(),
    ProfileScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(2.0),
        child: DotNavigationBar(
          borderRadius: 30,
          enablePaddingAnimation: false,
          enableFloatingNavBar: true,
          backgroundColor: Colors.white60,
          boxShadow: const  [
            BoxShadow(
                color: Colors.transparent,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 0)),
          ],
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.image_rounded),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.event_available),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: Theme.of(context).colorScheme.primary,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
          dotIndicatorColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.black54,
        ),
      ),
    );
  }
}
