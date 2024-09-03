import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_error_codes.dart';
import 'package:todo_app/model/user_collection.dart';
import 'package:todo_app/style/dialogue_utils/dialogue_utils.dart';
import 'package:todo_app/style/reusable_components/custom_form_field.dart';
import 'package:todo_app/ui/home_screen/home_screen.dart';
import '../../auth_provider.dart';
import '../../style/constants/constants.dart';
import 'package:todo_app/model/user.dart' as MyUser;

class RegisterScreen extends StatefulWidget
{
  static const String routeName = "Register Screen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          elevation: 0,
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
                CustomFormField(label: "Password Confirmation", action: TextInputAction.done, isPassword: true,
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

  createAccount() async
  {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context, listen: false);
    if(formKey.currentState?.validate()??false)
      {
        try
        {
          DialogueUtils.showLoadingDialogue(context);
          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );

          UserCollection.addUser(
            MyUser.User(
                id: credential.user!.uid,
                email: emailController.text,
                fullname: fullNameController.text
            ),
            provider.firebaseUser!.uid
          );

          MyUser.User user = MyUser.User(
            email: emailController.text.trim(),
            fullname: fullNameController.text,
            id: credential.user!.uid
          );
          
          provider.setUser(credential.user!, user);

          Navigator.pop(context);
          DialogueUtils.showMessageDialogue(context,
              message: "Account created successfully",
              onPress: (){
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
              }
          );

        }
        on FirebaseAuthException catch (error)
        {
          if (error.code == weakPassword)
          {
            Navigator.pop(context);
            DialogueUtils.showMessageDialogue(context,
                message: "The password provided is too weak.",
                onPress: (){
                  Navigator.pop(context);
                }
            );
          }
          else if (error.code == usedEmail)
          {
            Navigator.pop(context);
            DialogueUtils.showMessageDialogue(context,
                message: "The account already exists for that email.",
                onPress: (){
                  Navigator.pop(context);
                }
            );
          }
        }
        catch (error)
        {
          Navigator.pop(context);
          DialogueUtils.showMessageDialogue(context,
              message: "${error.toString()}",
              onPress: (){
                Navigator.pop(context);
              }
          );
        }
      }
  }
}
