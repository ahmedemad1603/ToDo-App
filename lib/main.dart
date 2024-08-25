import 'package:flutter/material.dart';
import 'package:todo_app/style/application_style/app_style.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';
import 'package:todo_app/ui/register_screen/register_screen.dart';

void main()
{
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
        RegisterScreen.routeName: (_) => RegisterScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
