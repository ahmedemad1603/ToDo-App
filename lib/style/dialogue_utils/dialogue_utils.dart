import 'package:flutter/material.dart';

class DialogueUtils
{

  static void showLoadingDialogue(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: SizedBox(
                height: 40,
                child: Center(child: CircularProgressIndicator())
            )
          );
        }
    );
  }
  static void showMessageDialogue(BuildContext context, {required String message, required void Function() onPress })
  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            content: Text(message, textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: onPress,
                child: Text("Ok")
              )
            ],
          );
        },
    );
  }
}