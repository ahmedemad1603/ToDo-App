import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider.dart';
import 'package:todo_app/ui/home_screen/home_screen.dart';
import 'package:todo_app/ui/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget
{
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context);
    Future.delayed(const Duration(milliseconds: 3250), () async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null){
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
      else{
        await provider.retrieveUser();
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }

    });
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png")).animate().fade(
        duration: const Duration(milliseconds: 3000),
        begin: 0,
        end: 1
      )
    );
  }
}
