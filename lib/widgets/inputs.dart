import 'package:flutter/material.dart';

class InputText extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardtype;
  final bool isPassword;

  const InputText({ 
  required this.icon, 
  required this.placeholder, 
  required this.textController, 
  this.keyboardtype = TextInputType.text, 
  this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 3, left: 5, bottom: 3, right: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.07),
                offset: const Offset(0, 5),
                blurRadius: 3)
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardtype,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder
        ),
      ),
    );
  }
}
