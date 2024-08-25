import 'package:flutter/material.dart';
import 'package:todo_app/style/reusable_components/custom_form_field.dart';
import '../../style/constants/constants.dart';

class RegisterScreen extends StatelessWidget
{
  static const String routeName = "Register Screen";

  RegisterScreen({super.key});

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReconfirmController = TextEditingController();
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
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
          title: const Text("Create Account"),
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
              children: [
                const SizedBox(height: 100),
                CustomFormField(label: "Full Name", type: TextInputType.name, controller: fullNameController,
                    validator: (value){
                      if(value == null || value.isEmpty)
                        {return "Please enter your name";}
                      return null;
                    }
                ),
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
                CustomFormField(label: "Phone Number", type: TextInputType.phone, controller: phoneNumberController,
                  validator: (value){
                    if(value == null || value.isEmpty)
                      {return "Please enter your phone number";}
                    if(value.length < 11)
                      {return "Enter a valid phone number containing 11 digits";}
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
                CustomFormField(label: "Password Re-Confirmation", action: TextInputAction.done, isPassword: true,
                  controller: passwordReconfirmController,
                  validator: (value){
                    if(value == null || value.isEmpty)
                    {return "Please enter the password";}
                    if(value != passwordController.text)
                      {return "The password you entered doesn't match your password";}
                    return null;
                  }
                ),
                const SizedBox(height: 90),
                ElevatedButton(
                    onPressed: (){
                      createAccount();
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
                        Text("Create Account", style: Theme.of(context).textTheme.labelSmall),
                        const Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white, size: 30
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  createAccount()
  {
    formKey.currentState?.validate();
  }
}
