import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String textButton;
  final String text;

  const Labels({Key? key, 
  required this.ruta, 
  required this.textButton, 
  required this.text}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(text, 
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500, 
            color: Colors.white70
            )
          ),
          TextButton(
            child: Text(textButton, 
              style: const TextStyle(
              fontSize: 17, 
              fontWeight: FontWeight.bold,
              color: Colors.white
              )
            ),
            onPressed: () => Navigator.pushNamed(context, ruta),
          ),
        ],
      ),
    );
  }
}

