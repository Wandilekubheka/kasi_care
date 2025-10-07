import 'package:flutter/material.dart';

class AppTabbar extends StatefulWidget {
  const AppTabbar({super.key});

  @override
  State<AppTabbar> createState() => _AppTabbarState();
}

class _AppTabbarState extends State<AppTabbar> {
  String currentTab = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Card(
        color: Theme.of(context).colorScheme.primary,
        margin: const EdgeInsets.all(24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    currentTab = 'home';
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    currentTab = 'search';
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  // Handle profile button press
                },
              ),
            ],
          ),
        ),
      ),

      body: Center(child: Text('App Tabbar')),
    );
  }
}
