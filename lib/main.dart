import 'package:flutter/material.dart';
import 'package:todo_app/style/application_style/app_style.dart';
import 'package:todo_app/ui/home_screen/home_screen.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';
import 'package:todo_app/ui/register_screen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen()
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
