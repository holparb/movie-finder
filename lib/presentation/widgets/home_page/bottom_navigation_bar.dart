import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.background;
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? const TextStyle(fontFamily: "AbeeZee", color: Colors.black)
              : const TextStyle(fontFamily: "AbeeZee", color: Colors.grey),
        ),
      ),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: iconColor,),
            icon: Icon(Icons.search_outlined, color: iconColor,),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: iconColor,),
            icon: Icon(Icons.home_outlined, color: iconColor,),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark, color: iconColor,),
            icon: Icon(Icons.bookmark_border, color: iconColor,),
            label: "My list",
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Theme.of(context).colorScheme.outline,
        surfaceTintColor: Colors.black12,
      ),
    );
  }
}
