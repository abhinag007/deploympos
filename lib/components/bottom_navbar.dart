import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/colors.dart';

BottomNavigationBar bottomNavbar() {
  int _selectedIndex = 0;
  bool isLoading = false;

  void onItemTapped(int index) {
    _selectedIndex = index;
  }

  return BottomNavigationBar(
    unselectedItemColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    currentIndex: _selectedIndex,
    onTap: onItemTapped,
    selectedItemColor: primaryColor,
    backgroundColor: Colors.white10,
    elevation: 0,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/ico2.svg'), label: ''),
      const BottomNavigationBarItem(
        icon: Icon(Icons.payment),
        label: 'Pay',
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/ico4.svg'), label: ''),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/setting.svg'), label: ''),
    ],
  );
}
