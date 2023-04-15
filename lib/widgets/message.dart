//import 'dart:html';

import 'package:chatapp/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  final String text;
  final String uid;
  final AnimationController animation;

  const ChatMessage({ Key? key,
   required this.text,
   required this.uid,
   required this.animation }) 
   : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut
        ),
        child: Container(
          child: uid == authProvider.usuario.uid 
          ? _myMessage() 
          : _otherMessage(),
        ),
      ),
    );
  }
  
  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 6, left: 50),
        padding: const EdgeInsets.all(8),
        child: Text(text, style: const TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: Colors.teal[300],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
  
 Widget _otherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 50, left: 6),
        padding: const EdgeInsets.all(8),
        child: Text(text, style: const TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: Colors.blueGrey[300],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}