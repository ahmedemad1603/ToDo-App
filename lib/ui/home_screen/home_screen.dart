import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider.dart';
import 'package:todo_app/todo_provider.dart';
import 'package:todo_app/ui/home_screen/tabs/settings_tab.dart';
import 'package:todo_app/ui/home_screen/tabs/tasks_tab.dart';
import 'package:todo_app/ui/home_screen/widgets/add_task_sheet.dart';
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
    TasksTab(),
    const SettingsTab()
  ];

  int currentIndex = 0;

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<ToDoProvider>(context, listen: false).refreshTasks(Provider.of<AuthUserProvider>(context, listen: false).firebaseUser!.uid);
    // });
  }

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
          showAddTaskBottomSheet();
        },
        child: const Icon(Icons.add, color: Colors.white)
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
            currentIndex = newIndex;
            setState(() {

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

  void showAddTaskBottomSheet()
  {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddTaskSheet(),
        isScrollControlled: true
    );
  }
}
