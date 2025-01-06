import 'package:flutter/material.dart';
import './tabs/home.dart';
import './tabs/activity.dart';
import './tabs/dashboard.dart';
import './tabs/profile.dart';
import './tabs/booking.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // int _selectedIndex = 0;
  int _selectedIndex = 3;
  final List<Widget> _pages = [
    const HomePage(),
    ActivityPage(),
    const BookingPage(),
    DashboardPage(),
    const ProfilePage()
  ];
  final List<Widget> _appBarTitle = [
    const Text("Home"),
    const Text("Start New Activity"),
    const Text("Create New Booking"),
    const Text("View Dashboard"),
    const Text("Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle[_selectedIndex],
        backgroundColor: Colors.blue[600],
        shadowColor: Colors.black26,
        elevation: 10.0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.blue,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined), label: 'Activity'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined), label: 'Booking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.space_dashboard_outlined), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
          ]),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton(
            backgroundColor:
                _selectedIndex == 2 ? Colors.blue : Colors.purple.shade100,
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.add)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
