import 'package:flutter/material.dart';

typedef Validation = String? Function(String?);

class CustomFormField extends StatefulWidget
{
  String label;
  TextInputType type;
  TextInputAction action;
  bool isPassword;
  Validation validator;
  TextEditingController controller;

  CustomFormField({
    super.key,
    required this.label,
    this.type = TextInputType.text,
    this.action = TextInputAction.next,
    this.isPassword = false,
    required this.validator,
    required this.controller
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  bool isObscured = true;

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.type,
          textInputAction: widget.action,
          obscureText: widget.isPassword? isObscured: false,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(color: Colors.black),
            suffixIcon: widget.isPassword
                ? IconButton(
                onPressed: (){
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon: Icon( isObscured
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded
                ),
                color: Theme.of(context).colorScheme.primary,
            )
                : null,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)
            )
          )
    );
  }
}
