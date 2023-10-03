import 'package:flutter/material.dart';
import 'package:krok_task/Screens/achievements_page.dart';
import '../Services/auth_service.dart';
import 'home_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomePage(), const AchievementsPage()];
  @override
  Widget build(BuildContext context) {
    var userNavBotBar = BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      iconSize: 24,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.light_mode_rounded),
          label: '',
        ),
      ],
    );

    var userAppBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.green, size: 24),
      toolbarHeight: 80,
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: GestureDetector(
                  onTap: () async {
                    AuthService().signOut();
                  },
                  child: Icon(Icons.exit_to_app_rounded))),
        )
      ],
    );

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: userNavBotBar,
      appBar: userAppBar,
    );
  }
}
