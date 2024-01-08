import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toku/style/style.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
int selectedIndex = 0;
  final List<Widget> page = [
    const Center(),
    const Center(),
    const Center(),
  ];

  final List<BottomNavigationBarItem> item = [
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(5.0),
        child: FaIcon(FontAwesomeIcons.house),
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(5.0),
        child: FaIcon(FontAwesomeIcons.magnifyingGlass),
      ),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(5.0),
        child: FaIcon(FontAwesomeIcons.earthAsia),
      ),
      label: 'My space',
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: page[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: item,
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        currentIndex: selectedIndex,
        unselectedItemColor: black.withOpacity(0.3),
        selectedItemColor: black,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 18,
        onTap: _onItemTapped,
      ),
    );
  }
  
}
