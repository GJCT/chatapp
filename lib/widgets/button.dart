import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {

  final String text;
  final Function() onPressed;

  const ButtonBlue({Key? key, 
  required this.text, 
  required this.onPressed}) 
  : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[400], // background
        elevation: 5,
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
