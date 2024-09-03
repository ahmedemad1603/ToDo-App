import 'package:flutter/material.dart';

class DialogueUtils
{

  static void showLoadingDialogue(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
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
                child: const Text("Ok")
              )
            ],
          );
        },
    );
  }
  static void showConfirmationDialogue(BuildContext context, {
    required String message,
    required void Function() onPositivePress,
    required void Function() onNegativePress,
  })
  {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          content: Text(message, textAlign: TextAlign.center),
          actions: [
            TextButton(
                onPressed: onPositivePress,
                child: const Text("Yes")
            ),
            TextButton(
                onPressed: onNegativePress,
                child: const Text("No")
            )
          ],
        );
      },
    );
  }
}