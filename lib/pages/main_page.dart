import 'package:flutter/material.dart';
import 'package:news1_app/pages/home_page.dart';
import 'package:news1_app/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0XFFF39E3A),
        selectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic/home.png',
              color: _selectedIndex == 0
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic/profile.png',
              color: _selectedIndex == 0
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
