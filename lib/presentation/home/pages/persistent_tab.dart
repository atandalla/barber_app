
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'home_page.dart';

class PersistentTab extends StatelessWidget {
  const PersistentTab({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: controller,
      backgroundColor: const Color(0xFF1C1C1E),
      navBarStyle: NavBarStyle.style9,
      screens: const [
        HomeScreen(),
        Center(child: Text('Citas', style: TextStyle(color: Colors.white))),
        Center(child: Text('Favoritos', style: TextStyle(color: Colors.white))),
        Center(child: Text('Perfil', style: TextStyle(color: Colors.white))),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Inicio"),
          activeColorPrimary: Colors.amber,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_today),
          title: ("Citas"),
          activeColorPrimary: Colors.amber,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite_border),
          title: ("Favoritos"),
          activeColorPrimary: Colors.amber,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_outline),
          title: ("Perfil"),
          activeColorPrimary: Colors.amber,
          inactiveColorPrimary: Colors.grey,
        ),
      ],
    );
  }
}