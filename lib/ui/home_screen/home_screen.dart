import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_screen/tabs/settings_tab.dart';
import 'package:todo_app/ui/home_screen/tabs/tasks_tab.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget
{
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        actions: [
          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
          },
          icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        elevation: 0,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.menu_rounded),
                label: "Tasks",
            ),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.settings),
                label: "Settings"
            )
          ]
        ),
      ),
      body: tabs[currentIndex],
    );
  }
}
