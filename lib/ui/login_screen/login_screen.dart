import 'package:flutter/material.dart';
import 'package:todo_app/ui/register_screen/register_screen.dart';
import '../../style/constants/constants.dart';
import '../../style/reusable_components/custom_form_field.dart';

class LoginScreen extends StatelessWidget
{
  static const String routeName = "Login Screen";

  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Login"),
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                CustomFormField(label: "Email", type: TextInputType.emailAddress, controller: emailController,
                    validator: (value){
                      if(value == null || value.isEmpty)
                      {return "Please enter your email";}
                      if(!isValidEmail(value))
                      {
                        return "Enter valid email in this format 'username@gmail.com'";
                      }
                      return null;
                    }
                ),
                CustomFormField(label: "Password", isPassword: true, controller: passwordController,
                    validator: (value){
                      if(value == null || value.isEmpty)
                      {return "Please enter your password";}
                      if(value.length < 6)
                      {return "Enter a valid password with 6 or more characters";}
                      return null;
                    }
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: (){
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        padding: const EdgeInsets.all(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Login", style: Theme.of(context).textTheme.labelSmall),
                        const Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white, size: 30
                        )
                      ],
                    )
                ),
                const SizedBox(height: 50),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: const Text("Or Create My Account", style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login()
  {
    formKey.currentState?.validate();
  }

}
