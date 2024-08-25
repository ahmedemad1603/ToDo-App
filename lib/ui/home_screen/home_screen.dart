import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List")
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
          )
        ]
      ),
    );
  }
}
