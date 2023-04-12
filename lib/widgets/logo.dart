import 'package:flutter/material.dart';

class Logo extends StatelessWidget{

  final String title;

  const Logo({Key? key, 
  required this.title}) 
  : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            const Image(image: AssetImage('assets/tag-logo.png')),
            const SizedBox(height: 15,),
            Text(title, style: const TextStyle(fontSize: 25, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}